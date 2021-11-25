//
//  LocationsTableViewCell.swift
//  PhotoPlan
//
//  Created by Andrey on 25.11.21.
//

import UIKit

final class LocationsTableViewCell: UITableViewCell {
  
  @IBOutlet private weak var whiteView: UIView!
  @IBOutlet private weak var colorView: UIView!
  @IBOutlet private weak var collectionView: UICollectionView!
  @IBOutlet private weak var nameTextField: UITextField!
  
  static let cellName = "LocationsTableViewCell"
  
  var images: [LocationModel] = []
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.backgroundColor = UIColor.init(rgb: 0xFAFAFA)
    setupCollectionView()
    setupView()
  }
  
  private func setupCollectionView(){
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = UIColor.init(rgb: 0xFAFAFA)
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
    
  }
  
}

extension LocationsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 7
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationCollectionViewCell.cellName, for: indexPath) as? LocationCollectionViewCell else {return UICollectionViewCell()}
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (collectionView.frame.width - 20) / 3, height: (collectionView.frame.height - 10) / 2)
  }
  
}
