//
//  LocationsTableViewCell.swift
//  PhotoPlan
//
//  Created by Andrey on 25.11.21.
//

import UIKit
import FirebaseStorage
import Firebase

final class LocationsTableViewCell: UITableViewCell, ImageVCDelegate {
  
  @IBOutlet private weak var whiteView: UIView!
  @IBOutlet private weak var colorView: UIView!
  @IBOutlet private weak var collectionView: UICollectionView!
  @IBOutlet private weak var nameTextField: UITextField!
  
  var viewModel: LocationsViewModelProtocol = LocationsViewModel(location: .init(image: [], imageUrl: []))
  
  var index = Int()
  var completion: ((UIImagePickerController) -> ())?
  var imageCompletion: ((UIViewController) -> ())?
  
  private let imagePicker = UIImagePickerController()
  static let cellName = "LocationsTableViewCell"
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.backgroundColor = UIColor.init(rgb: 0xFAFAFA)
    imagePicker.delegate = self
    nameTextField.delegate = self
    setupCollectionView()
    setupView()
    bind()
  }
  
  
  private func setupCollectionView(){
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = UIColor.init(rgb: 0xEDF3F4)
    collectionView.register(UINib(nibName: LocationCollectionViewCell.cellName, bundle: nil), forCellWithReuseIdentifier: LocationCollectionViewCell.cellName)
  }
  
  private func setupView() {
    whiteView.layer.cornerRadius = 20
    whiteView.layer.shadowOffset = CGSize(width: -5, height: 10)
    whiteView.layer.shadowOpacity = 0.4
    whiteView.layer.shadowRadius = 5
    whiteView.layer.shadowColor = UIColor.gray.cgColor
    
    colorView.layer.cornerRadius = 15
    colorView.backgroundColor = UIColor.init(rgb: 0xEDF3F4)
  }
  
  @IBAction func buttonDidTapped(){
    completion?(imagePicker)
  }
  
  private func bind() {
    viewModel.loadData()
    viewModel.imagesDidChange = {
      self.collectionView.reloadData()
    }
    viewModel.locationNameDidChange = { [weak self] in
      self?.nameTextField.text = self?.viewModel.locationName
      self?.collectionView.reloadData()
    }
    
  }
  
  func setupImageView() -> UIImage {
    guard let location = viewModel.location else { return UIImage() }
    return location.image[index]
  }
  
}

extension LocationsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let location = viewModel.location else { return 0 }
    
    return location.image.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationCollectionViewCell.cellName, for: indexPath) as? LocationCollectionViewCell else {return UICollectionViewCell()}
    
    guard let  location = viewModel.location else { return UICollectionViewCell()}
    
    cell.setupImage(image: location.image[indexPath.item])
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
  
    let nextVC = ImageVC(nibName: "ImageVC", bundle: nil)
    nextVC.delegate = self
    index = indexPath.item
    imageCompletion?(nextVC)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (collectionView.frame.width - 20) / 3, height: (collectionView.frame.height - 10) / 2)
  }
  
}

extension LocationsTableViewCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[.originalImage] as? UIImage {
      
      viewModel.location?.image.append(image)
      viewModel.uploadPhoto(image: image)
      
    }
    picker.dismiss(animated: true, completion: nil)
  }
  
}

extension LocationsTableViewCell: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    
    if let text = textField.text, textField.text != "" {
      viewModel.addNewDataInFirebase(locationName: text)
    }
    
    return true
  }
  
}
