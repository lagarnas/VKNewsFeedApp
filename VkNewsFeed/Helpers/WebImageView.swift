//
//  WebImageView.swift
//  VkNewsFeed
//
//  Created by Анастасия Лагарникова on 03.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation
import UIKit


class WebImageView: UIImageView {
  private var currentURLString: String?
  
  func set(imageURL: String?) {
    currentURLString = imageURL
    guard let imageURL = imageURL, let url = URL(string: imageURL) else {
      self.image = nil
      return }
    
    

    //проверяем есть ли картинка в кэше
    if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
      self.image = UIImage(data: cachedResponse.data)
      return
    }
    
    let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
      DispatchQueue.main.async {
        guard let data = data, let response = response else { return }
        // добавляем картинку в кэш
        self.handleLoadedImage(data: data, response: response)
      }
    }
    dataTask.resume()
  }
  
  private func handleLoadedImage(data: Data, response: URLResponse) {
    guard let responseURL = response.url else { return }
    let cachedResponse = CachedURLResponse(response: response, data: data)
    URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
    if responseURL.absoluteString == currentURLString {
      self.image = UIImage(data: data)
    }
  }
}
