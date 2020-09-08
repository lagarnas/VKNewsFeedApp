//
//  NewsfeedCellGalleryCollectionViewCell.swift
//  VkNewsFeed
//
//  Created by Анастасия Лагарникова on 07.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation
import UIKit

class NewsfeedCellGalleryCollectionViewCell: UICollectionViewCell {
  
  static let reuseID = "galleryCell"
  
  let myImageView: WebImageView = {
    let imageView = WebImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    imageView.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.8980392157, blue: 0.9098039216, alpha: 1)
    return imageView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(myImageView)
    
    // myImageView constraints
    myImageView.fillSuperview()
  }
  
  override func prepareForReuse() {
    myImageView.image = nil
  }
  
  func configure(imageUrl: String?) {
    myImageView.set(imageURL: imageUrl)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    myImageView.layer.masksToBounds = true
    myImageView.layer.cornerRadius = 10
    self.layer.shadowRadius = 3
    self.layer.shadowOpacity = 0.4
    self.layer.shadowOffset = CGSize(width: 2.5, height: 4)
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
