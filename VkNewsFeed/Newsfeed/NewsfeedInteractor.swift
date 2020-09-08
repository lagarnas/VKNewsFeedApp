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
  
  private var revealdedPostIds = [Int]()
  private var feedResponse: FeedResponse?
  
  private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
  
  func makeRequest(request: Newsfeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsfeedService()
    }
    
    switch request {
    case .getNewsFeed:
      fetcher.getFeed { [weak self] feedResponse in
        guard let self = self else { return }
        self.feedResponse = feedResponse
        self.presentFeed()
      }
    case .revealPost(postId: let postId):
      revealdedPostIds.append(postId)
      presentFeed()
      
    case .getUser:
      fetcher.getUser { [weak self] userResponse in
        guard let self = self else { return }
        self.presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentUserInfo(userResponse: userResponse))
      }
    }
  }
  
  private func presentFeed() {
    guard let feedResponse = feedResponse else { return }
    self.presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentNewsFeed(feedResponse: feedResponse, revealdedPostIds: revealdedPostIds))
  }
}
