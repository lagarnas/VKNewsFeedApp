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
  
  static var numberOfRows = 1
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
    contenWidth = 0
    cache = []
    guard
      cache.isEmpty == true, let collectionView = collectionView else { return }
    
    var photos = [CGSize]()
    
    for item in 0..<collectionView.numberOfItems(inSection: 0) {
      let indexPath = IndexPath(item: item, section: 0)
      let photoSize = delegate.collectionView(collectionView, photoAddIndexPath: indexPath)
      photos.append(photoSize)
    }
    
    let superViewWidth = collectionView.frame.width
    guard var rowHeight = RowLayout.rowHeghtCounter(superViewWidth: superViewWidth, photosArray: photos) else { return }
    
    rowHeight = rowHeight / CGFloat(RowLayout.numberOfRows)
    
    let photosRatios = photos.map { $0.height / $0.width}
    
    var yOffset = [CGFloat]()
    for row in 0..<RowLayout.numberOfRows {
      yOffset.append(CGFloat(row) * rowHeight)
    }
    
    var xOffset = [CGFloat](repeating: 0, count: RowLayout.numberOfRows)
    
    var row = 0
    
    for item in 0..<collectionView.numberOfItems(inSection: 0) {
      let indexPath = IndexPath(item: item, section: 0)
      let ratio = photosRatios[indexPath.row]
      let width = rowHeight / ratio
      let frame = CGRect(x: xOffset[row], y: yOffset[row], width: width, height: rowHeight)
      let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
      
      let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      attribute.frame = insetFrame
      cache.append(attribute)
      
      contenWidth = max(contenWidth, frame.maxX)
      xOffset[row] = xOffset[row] + width
      row = row < (RowLayout.numberOfRows - 1) ? row + 1 : 0
    }
  }
  
  static func rowHeghtCounter(superViewWidth: CGFloat, photosArray: [CGSize]) -> CGFloat? {
    var rowHeight: CGFloat
    
    let photoWidthMinRatio = photosArray.min {
      ($0.height / $0.width) < ($1.height / $1.width)
    }
    guard let myPhotoWidthMinRatio = photoWidthMinRatio else { return nil}
    
    let difference = superViewWidth / myPhotoWidthMinRatio.width
    
    rowHeight = myPhotoWidthMinRatio.height * difference
    
    rowHeight = rowHeight * CGFloat(RowLayout.numberOfRows)
    
    return rowHeight
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    
    var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
    
    for  attribute in cache {
      if attribute.frame.intersects(rect) {
        visibleLayoutAttributes.append(attribute)
      }
    }
    return visibleLayoutAttributes
  }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    cache[indexPath.row]
  }
}
