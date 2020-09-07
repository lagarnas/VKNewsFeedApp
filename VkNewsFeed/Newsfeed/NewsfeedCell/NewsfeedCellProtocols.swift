//
//  NewsfeedCell.swift
//  VkNewsFeed
//
//  Created by Анастасия Лагарникова on 03.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation
import UIKit

protocol FeedCellViewModel {
  var iconUrlString: String { get }
  var name: String { get }
  var date: String { get }
  var post: String? { get }
  var likes: String? { get }
  var comments: String? { get }
  var shares: String? { get }
  var views: String? { get }
  var photoAttachments: [FeedCellPhotoAttachmentViewModel] { get }
  var sizes: FeedCellSizes { get }
  
}

protocol FeedCellSizes {
  var postLabelFrame: CGRect { get }
  var attachmentFrame: CGRect { get }
  var bottomViewFrame: CGRect { get }
  var totalHeight: CGFloat { get }
  var moreTextButtonFrame: CGRect { get }
}

protocol FeedCellPhotoAttachmentViewModel {
  var photoUrlString: String? { get }
  var width: Int { get }
  var height: Int { get }
}


