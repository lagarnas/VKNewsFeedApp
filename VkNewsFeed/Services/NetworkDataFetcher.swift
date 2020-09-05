//
//  NetworkDataFetcher.swift
//  VkNewsFeed
//
//  Created by Анастасия Лагарникова on 03.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation

protocol DataFetcher {
  func getFeed(response: @escaping (FeedResponse?)-> Void)
}

struct NetworkDataFetcher: DataFetcher {
  
  let networking: Networking
  init(networking: Networking) {
    self.networking = networking
  }
  
  func getFeed(response: @escaping (FeedResponse?) -> Void) {
    
    let params = ["filters": "post,photo"]
    
    networking.request(path: API.newsfeed, params: params) { (data, error) in
      if let error = error {
        print("Error received requesting data: \(error.localizedDescription)")
        response(nil)
      }
      
      let decoded = self.decodeJSON(type: FeedResponseWrapped.self, from: data)
      response(decoded?.response)
    }
    
    
  }
  
  private func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    guard let data = data, let response = try? decoder.decode(type, from: data) else { return nil }
    return response
  }
  
  
}
