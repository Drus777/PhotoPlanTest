//
//  LocationCollectionViewCell.swift
//  PhotoPlan
//
//  Created by Andrey on 25.11.21.
//

import UIKit

final class LocationCollectionViewCell: UICollectionViewCell {
  
  static let cellName = "LocationCollectionViewCell"
  
  @IBOutlet private weak var image: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupImage()
  }
  
  func setupImage() {
    image.layer.cornerRadius = 15
  }
  
}
