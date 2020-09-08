//
//  NewsfeedInteractor.swift
//  VkNewsFeed
//
//  Created by Анастасия Лагарникова on 03.09.2020.
//  Copyright (c) 2020 lagarnas. All rights reserved.
//

import UIKit

protocol NewsfeedBusinessLogic {
  func makeRequest(request: Newsfeed.Model.Request.RequestType)
}

class NewsfeedInteractor: NewsfeedBusinessLogic {
  
  var presenter: NewsfeedPresentationLogic?
  var service: NewsfeedService?
  

  func makeRequest(request: Newsfeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsfeedService()
    }
    
    switch request {
    case .getNewsFeed:
      service?.getFeed(completion: { [weak self] revealPostIds, feed in
        guard let self = self else { return }
        self.presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentNewsFeed(feedResponse: feed, revealdedPostIds: revealPostIds))
      })
    case .getUser:
      service?.getUser(completion: {[weak self] user in
        guard let self = self else { return }
        self.presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentUserInfo(userResponse: user))
      })
    case .revealPost(postId: let postId):
      service?.revealPostIds(forPostId: postId, completion: { [weak self] revealPostIds, feed in
        guard let self = self else { return }
        self.presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentNewsFeed(feedResponse: feed, revealdedPostIds: revealPostIds))
      })
    case .getNextBatch:
      self.presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentFooterLoader)
      service?.getNextBatch(completion: { [weak self] revealPostIds, feed in
        guard let self = self else { return }
        self.presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentNewsFeed(feedResponse: feed, revealdedPostIds: revealPostIds))
      })
    }
  }
}
