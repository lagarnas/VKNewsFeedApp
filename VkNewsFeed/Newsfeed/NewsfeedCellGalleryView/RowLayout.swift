//
//  RowLayout.swift
//  VkNewsFeed
//
//  Created by Анастасия Леонтьева on 08.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation
import UIKit

protocol RowLayoutDelegate: class {
  func collectionView(_ collectionView: UICollectionView, photoAddIndexPath indexPath: IndexPath) -> CGSize
}

class RowLayout: UICollectionViewLayout {
  
  weak var delegate: RowLayoutDelegate!
  
  fileprivate var numberOfRows = 1
  fileprivate var cellPadding: CGFloat = 8
  
  fileprivate var cache = [UICollectionViewLayoutAttributes]()
  
  fileprivate var contenWidth: CGFloat = 0
  
  //константа
  fileprivate var contentHeight: CGFloat {
    
    guard let collectionView = collectionView else { return 0 }
    
    let insets = collectionView.contentInset
    
    return collectionView.bounds.height - (insets.left + insets.right)
  }
  
  override var collectionViewContentSize: CGSize {
    return CGSize(width: contenWidth, height: contentHeight)
  }
  
  override func prepare() {
    guard
      cache.isEmpty == true, let collectionView = collectionView else { return }
    
    var photos = [CGSize]()
    
    for item in 0..<collectionView.numberOfItems(inSection: 0) {
      let indexPath = IndexPath(item: item, section: 0)
      let photoSize = delegate.collectionView(collectionView, photoAddIndexPath: indexPath)
      photos.append(photoSize)
    }
    
    let superViewWidth = collectionView.frame.width
    guard let rowHeight = self.rowHeghtCounter(superViewWidth: superViewWidth, photosArray: photos) else { return }
  }
  
  private func rowHeghtCounter(superViewWidth: CGFloat, photosArray: [CGSize]) -> CGFloat? {
    var rowHeight: CGFloat
    
    let photoWidthMinRatio = photosArray.min {
      ($0.height / $0.width) < ($1.height / $1.width)
    }
    guard let myPhotoWidthMinRatio = photoWidthMinRatio else { return nil}
    
    let difference = superViewWidth / myPhotoWidthMinRatio.width
    rowHeight = myPhotoWidthMinRatio.height * difference
    
    return rowHeight
  }
}
