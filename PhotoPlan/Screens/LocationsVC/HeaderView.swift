//
//  HeaderView.swift
//  PhotoPlan
//
//  Created by Andrey on 25.11.21.
//

import UIKit

final class HeaderView: UIView {

  let imageView = UIImageView()
  let label = UILabel()

  init() {
    super.init(frame: CGRect.zero)
    self.addSubview(imageView)
    self.addSubview(label)

    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    imageView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    imageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleToFill
    imageView.image = UIImage(named: "header")
    
    label.translatesAutoresizingMaskIntoConstraints = false
    label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    label.text = "ЛОКАЦИИ"
    label.font = UIFont(name: "Apple SD Gothic Neo", size: 30)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
