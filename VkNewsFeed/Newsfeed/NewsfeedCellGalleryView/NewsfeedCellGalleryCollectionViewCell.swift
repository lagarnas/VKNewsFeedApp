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
    imageView.contentMode = .scaleAspectFit
    imageView.backgroundColor = .yellow
    return imageView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(myImageView)
    backgroundColor = .darkGray
    
    // myImageView constraints
    myImageView.fillSuperview()
  }
  
  override func prepareForReuse() {
    myImageView.image = nil
  }
  
  func configure(imageUrl: String?) {
    myImageView.set(imageURL: imageUrl)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
