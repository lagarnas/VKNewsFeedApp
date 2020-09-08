//
//  API.swift
//  VkNewsFeed
//
//  Created by Анастасия Лагарникова on 03.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation

struct API {
  
  static let scheme = "https"
  static let host = "api.vk.com"
  static let version = "5.122"
  
  static let newsfeed = "/method/newsfeed.get"
  static let user = "/method/users.get"
}
