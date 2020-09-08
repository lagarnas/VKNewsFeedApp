//
//  NewsfeedCellGalleryCollectionView.swift
//  VkNewsFeed
//
//  Created by Анастасия Лагарникова on 07.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation
import UIKit

class NewsfeedCellGalleryCollectionView: UICollectionView {
  
  var photos = [FeedCellPhotoAttachmentViewModel]()
  
  init() {
    let rowLayout = RowLayout()
    super.init(frame: .zero, collectionViewLayout: rowLayout)
    delegate = self
    dataSource = self
    
    backgroundColor = .white
    
    showsHorizontalScrollIndicator = false
    showsVerticalScrollIndicator = false
    
    register(NewsfeedCellGalleryCollectionViewCell.self, forCellWithReuseIdentifier: NewsfeedCellGalleryCollectionViewCell.reuseID)
  }
  
  func set(photos: [FeedCellPhotoAttachmentViewModel]) {
    self.photos = photos
    contentOffset = CGPoint.zero
    reloadData()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}


extension NewsfeedCellGalleryCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    photos.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = dequeueReusableCell(withReuseIdentifier:  NewsfeedCellGalleryCollectionViewCell.reuseID, for: indexPath) as! NewsfeedCellGalleryCollectionViewCell
    cell.configure(imageUrl: photos[indexPath.row].photoUrlString)
    
    return cell
  }
}

extension NewsfeedCellGalleryCollectionView: RowLayoutDelegate {
  func collectionView(_ collectionView: UICollectionView, photoAddIndexPath indexPath: IndexPath) -> CGSize {
    let width = photos[indexPath.row].width
    let height = photos[indexPath.row].height
    return CGSize(width: width, height: height)
  }
  
  
}
