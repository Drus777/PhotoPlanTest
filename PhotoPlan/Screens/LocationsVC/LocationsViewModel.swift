//
//  LocationsViewModel.swift
//  PhotoPlan
//
//  Created by Andrey on 26.11.21.
//

import UIKit
import FirebaseStorage
import Firebase

protocol LocationsViewModelProtocol {
  var location: LocationModel? { get set }
  var locationName: String? { get set }
  
  var imagesDidChange: (() -> Void)? { get set }
  var locationNameDidChange: (() -> Void)? { get set }
  
  func addNewDataInFirebase(locationName: String)
  func uploadPhoto(image: UIImage)
  func loadData()
}

final class LocationsViewModel: LocationsViewModelProtocol {
  
  init(location: LocationModel) {
    self.location = location
  }
  
  var location: LocationModel?  {
    didSet {
      imagesDidChange?()
    }
  }
  
  var locationName: String? {
    didSet {
      locationNameDidChange?()
    }
  }
  
  var imagesDidChange: (() -> Void)?
  var locationNameDidChange: (() -> Void)?
  
  func addNewDataInFirebase(locationName: String) {
    let db = Firestore.firestore()
    
    let newDocument = db.collection("users").document("locations")
    newDocument.updateData([
      "locationName" : locationName
    ])
    { error in
      if error != nil {
        print("Error adding document: \(error?.localizedDescription)")
      }
    }
  }
  
  // MARK: - upload photo to firebase
  func uploadPhoto(image: UIImage) {
    upload(photo: image) { result in
      switch result {
      case .success(let url):
        let db = Firestore.firestore()
        let documentRef = db.collection("users").document("locations")
        
        documentRef.getDocument { document, _ in
          if let document = document, document.exists {
            
            if  let documentData = document.data(),
                let oldUrl = documentData["imageURL"] as? [String] {
              documentRef.updateData([
                "imageURL" : oldUrl + [url.absoluteString]
              ])
            } else {
              documentRef.updateData([
                "imageURL": [url.absoluteString]
              ])
            }
            
          }
        }
        
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  
  private func upload(photo: UIImage, completion: @escaping (Result<URL, Error>) -> ()){
    
    let reference = Storage.storage().reference().child("images").child("\(location?.image.count)")
    
    guard let imageData = photo.jpegData(compressionQuality: 0.4) else { return }
    
    let metadata = StorageMetadata()
    metadata.contentType =  "image/jpeg"
    
    reference.putData(imageData, metadata: metadata) { metadata, error in
      guard let _ = metadata else {
        completion(.failure(error!))
        return
      }
      reference.downloadURL { url, error in
        guard let url = url else {
          completion(.failure(error!))
          return
        }
        completion(.success(url))
      }
    }
  }
  
  // MARK: - get data from firestore
  
   func loadData() {
    let db = Firestore.firestore()
    let documentRef = db.collection("users").document("locations")
    
    documentRef.getDocument { [weak self] document, error in
      if let document = document, document.exists {
        
        guard
          let documentData = document.data(),
          let imageUrlString = documentData["imageURL"] as? [String],
          let locationName = documentData["locationName"] as? String
        else { return }
        
        imageUrlString.forEach{ element in
          guard let url = URL(string: element) else { return }
          self?.downloadImage(from: url)
        }
        self?.locationName = locationName
      }
    }
    
  }
  
  // MARK: - getImageFromUrl
  
  private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
      URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
  }
  
  private func downloadImage(from url: URL) {
      print("Download Started")
      getData(from: url) { data, response, error in
          guard let data = data, error == nil else { return }
        
          DispatchQueue.main.async() { [weak self] in
            guard let image = UIImage(data: data) else { return }
            self?.location?.image.append(image)
          }
      }
  }
  
}
