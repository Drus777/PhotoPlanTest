//
//  LocationCollectionViewCell.swift
//  PhotoPlan
//
//  Created by Andrey on 25.11.21.
//

import UIKit

final class LocationCollectionViewCell: UICollectionViewCell {
  
  static let cellName = "LocationCollectionViewCell"
  
  @IBOutlet private weak var imageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func setupImage(image: UIImage) {
    imageView.layer.cornerRadius = 15
    imageView.image = image
  }
  
}
