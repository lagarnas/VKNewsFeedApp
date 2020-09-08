//
//  NetworkService.swift
//  VkNewsFeed
//
//  Created by Анастасия Лагарникова on 03.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation

protocol Networking {
  
  func request(path: String, params: [String: String], completion: @escaping (Data?, Error?)-> Void)
}

final class NetworkService: Networking {
  
  private let authService: AuthService
  
  init(authService: AuthService = AppDelegate.shared().authService) {
    self.authService = authService
  }
  
  func request(path: String, params: [String : String], completion: @escaping (Data?, Error?) -> Void) {
    
    guard let token = authService.token else { return }
    let params = params
    var allParams = params
    allParams["access_token"] = token
    allParams["v"] = API.version
    let url = self.url(from: path, params: allParams)
    

    
    let request = URLRequest(url: url)
    
    let task = createDataTask(from: request, completion: completion)
    task.resume()
  }
  
  private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void)-> URLSessionDataTask {
    
    return URLSession.shared.dataTask(with: request) { (data, response, error) in
      DispatchQueue.main.async {
        completion(data, error)
      }
    }
  }
  
  private func url(from path: String, params: [String: String]) -> URL {
    
    var components = URLComponents()
    components.scheme = API.scheme
    components.host = API.host
    components.path = path
    components.queryItems = params.map{ URLQueryItem(name: $0, value: $1) }
    return components.url!
  }
}
