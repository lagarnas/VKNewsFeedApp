//
//  UserResponse.swift
//  VkNewsFeed
//
//  Created by Анастасия Леонтьева on 08.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation

struct UserResponseWrapped: Decodable {
  let response: [UserResponse]
}

struct UserResponse: Decodable {
  let photo100: String?
}
