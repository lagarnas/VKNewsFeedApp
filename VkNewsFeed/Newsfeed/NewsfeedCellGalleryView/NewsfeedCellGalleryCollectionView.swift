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
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let rowLayout = RowLayout()
    super.init(frame: .zero, collectionViewLayout: rowLayout)
    delegate = self
    dataSource = self
    
    register(NewsfeedCellGalleryCollectionViewCell.self, forCellWithReuseIdentifier: NewsfeedCellGalleryCollectionViewCell.reuseID)
  }
  
  func set(photos: [FeedCellPhotoAttachmentViewModel]) {
    self.photos = photos
    reloadData()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}


extension NewsfeedCellGalleryCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    photos.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = dequeueReusableCell(withReuseIdentifier:  NewsfeedCellGalleryCollectionViewCell.reuseID, for: indexPath) as! NewsfeedCellGalleryCollectionViewCell
    cell.configure(imageUrl: photos[indexPath.row].photoUrlString)
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    CGSize(width: frame.width, height: frame.height)
  }
}


