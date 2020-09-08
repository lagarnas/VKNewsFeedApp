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
        case getUser
        case revealPost(postId: Int)
        case getNextBatch
      }
    }
    struct Response {
      enum ResponseType {
        case presentNewsFeed(feedResponse: FeedResponse, revealdedPostIds: [Int])
        case presentUserInfo(userResponse: UserResponse?)
        case presentFooterLoader
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case dispayNewsFeed(feedViewModel: FeedViewModel)
        case displayUser(userViewModel: UserViewModel)
        case displayFooterLoader
      }
    }
  }
}

struct UserViewModel: TitleViewViewModel {
  
  var photoUrlString: String?
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
  let footerTitle: String?
  
}
