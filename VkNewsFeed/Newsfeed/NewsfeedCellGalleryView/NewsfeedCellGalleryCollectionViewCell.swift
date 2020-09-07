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
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .darkGray
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
