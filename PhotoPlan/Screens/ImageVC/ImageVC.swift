//
//  ImageVC.swift
//  PhotoPlan
//
//  Created by Andrey on 26.11.21.
//

import UIKit

protocol ImageVCDelegate: AnyObject {
  func setupImageView() -> UIImage
}

class ImageVC: UIViewController {
  
  @IBOutlet private weak var imageView: UIImageView!
  
  weak var delegate: ImageVCDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let image = delegate?.setupImageView() else { return }
    setupImageView(image: image)
  }
  
  private func setupImageView(image: UIImage) {
    imageView.image = image
  }
  
  
}
