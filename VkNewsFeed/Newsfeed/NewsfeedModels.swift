//
//  NewsfeedModels.swift
//  VkNewsFeed
//
//  Created by Анастасия Лагарникова on 03.09.2020.
//  Copyright (c) 2020 lagarnas. All rights reserved.
//

import UIKit

enum Newsfeed {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getNewsFeed
        case revealPost(postId: Int)
      }
    }
    struct Response {
      enum ResponseType {
        case presentNewsFeed(feedResponse: FeedResponse, revealdedPostIds: [Int])
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case dispayNewsFeed(feedViewModel: FeedViewModel)
      }
    }
  }
}

struct FeedViewModel {
  struct Cell: FeedCellViewModel {
    
    var postId: Int
    var iconUrlString: String
    var name: String
    var date: String
    var post: String?
    var likes: String?
    var comments: String?
    var shares: String?
    var views: String?
    var photoAttachments: [FeedCellPhotoAttachmentViewModel]
    var sizes: FeedCellSizes
  }
  
  struct FeedCellPhotoAttachment: FeedCellPhotoAttachmentViewModel  {
    
    var photoUrlString: String?
    var width: Int
    var height: Int
    
  }
  
  let cells: [Cell]
}
