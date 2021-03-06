//
//  NewsfeedPresenter.swift
//  VkNewsFeed
//
//  Created by Анастасия Лагарникова on 03.09.2020.
//  Copyright (c) 2020 lagarnas. All rights reserved.
//

import UIKit

protocol NewsfeedPresentationLogic {
  func presentData(response: Newsfeed.Model.Response.ResponseType)
}

class NewsfeedPresenter: NewsfeedPresentationLogic {
  
  weak var viewController: NewsfeedDisplayLogic?
  
  var cellLayoutCalculator: FeedCellLayoutCalculatorProtocol = NewsfeedCellLayoutCalculator()
  
  let dateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.locale = Locale(identifier: "ru_RU")
    df.dateFormat = "d MMM 'в' HH:mm"
    return df
  }()
  
  func presentData(response: Newsfeed.Model.Response.ResponseType) {
    
    switch response {
    case .presentNewsFeed(let feedResponse, let revealdedPostIds):
      
      let cells = feedResponse.items.map {
        cellViewModel(from: $0,
                      profiles: feedResponse.profiles,
                      groups: feedResponse.groups,
                      revealdedPostIds: revealdedPostIds)
      }
      
      let footerTitle = String.localizedStringWithFormat(NSLocalizedString("newsfeed cells count", comment: ""), cells.count)
      let feedViewModel = FeedViewModel(cells: cells, footerTitle: footerTitle)
      
      viewController?.displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData.dispayNewsFeed(feedViewModel: feedViewModel))
    case .presentUserInfo(userResponse: let userResponse):
      let userViewModel = UserViewModel(photoUrlString: userResponse?.photo100)
      viewController?.displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData.displayUser(userViewModel: userViewModel))
    case .presentFooterLoader:
      viewController?.displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData.displayFooterLoader)
    }
  }
  
  private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group], revealdedPostIds: [Int]) -> FeedViewModel.Cell {
    
    let profile = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
    
    let photoAttachments = self.photoAttachments(feedItem: feedItem)
    let date = Date(timeIntervalSince1970: feedItem.date)
    let dateTitle = dateFormatter.string(from: date)
    
    let isFullSized = revealdedPostIds.contains(feedItem.postId)
    
    let sizes = cellLayoutCalculator.sizes(postText: feedItem.text, photoAttachments: photoAttachments, isFullSizedPost: isFullSized)
    
    let postText = feedItem.text?.replacingOccurrences(of: "<br>", with: "/n")
    
    return FeedViewModel.Cell(postId: feedItem.postId,
                              iconUrlString: profile.photo,
                              name: profile.name,
                              date: dateTitle,
                              post: postText,
                              likes: formattedCounter(feedItem.likes?.count),
                              comments: formattedCounter(feedItem.comments?.count),
                              shares: formattedCounter(feedItem.reposts?.count),
                              views: formattedCounter(feedItem.views?.count),
                              photoAttachments: photoAttachments,
                              sizes: sizes
    )
  }
  
  private func formattedCounter(_ counter: Int?) -> String? {
    guard let counter = counter, counter > 0 else { return nil }
    var counterString = String(counter)
    if 4...6 ~= counterString.count {
      counterString = String(counterString.dropLast(3)) + "K"
    } else if counterString.count > 6 {
      counterString = String(counterString.dropLast(6)) + "M"
    }
    
    return counterString
  }
  
  private func profile(for sourceId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresentable {
    let profilesOrGroups: [ProfileRepresentable] = sourceId >= 0 ? profiles : groups
    let normalSourceId = sourceId >= 0 ? sourceId : -sourceId
    let profileRepresentable = profilesOrGroups.first { myProfileRepresentable -> Bool in
      myProfileRepresentable.id == normalSourceId
    }
    return profileRepresentable!
  }
  
  private func photoAttachment(feedItem: FeedItem) -> FeedViewModel.FeedCellPhotoAttachment? {
    guard let photos = feedItem.attachments?.compactMap({ $0.photo }), let firstPhoto = photos.first else { return nil }
    return FeedViewModel.FeedCellPhotoAttachment(photoUrlString: firstPhoto.srcBIG,
                                                 width: firstPhoto.widht,
                                                 height: firstPhoto.height)
  }
  private func photoAttachments(feedItem: FeedItem) -> [FeedViewModel.FeedCellPhotoAttachment] {
    guard let attachments = feedItem.attachments else { return []}
    return attachments.compactMap { attachment -> FeedViewModel.FeedCellPhotoAttachment? in
      guard let photo = attachment.photo else  { return nil }
      return FeedViewModel.FeedCellPhotoAttachment(photoUrlString: photo.srcBIG,
                                                   width: photo.widht,
                                                   height: photo.height)
    }
  }
}
