//
//  String + Height.swift
//  VkNewsFeed
//
//  Created by Анастасия Лагарникова on 04.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation
import UIKit

extension String {
  func height(width: CGFloat, font: UIFont) -> CGFloat {
    let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
    
    let size = self.boundingRect(with: textSize,
                                 options: .usesLineFragmentOrigin,
                                 attributes: [NSAttributedString.Key.font: font],
                                 context: nil)
    
    return ceil(size.height)
  }
}
