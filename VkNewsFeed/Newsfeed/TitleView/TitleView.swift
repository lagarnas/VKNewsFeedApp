//
//  TitleView.swift
//  VkNewsFeed
//
//  Created by Анастасия Леонтьева on 08.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation
import UIKit

class TitleView: UIView {
  
  private var textField = InsetableTextField()
  
  private var avatarView: WebImageView = {
    let imageView = WebImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.backgroundColor = .orange
    imageView.clipsToBounds = true
    
    return imageView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    addSubview(textField)
    addSubview(avatarView)
    makeConstraints()
  }
  
  private func makeConstraints() {
    //avatarView constraints
    avatarView.anchor(top: topAnchor,
                      leading: nil,
                      bottom: nil,
                      trailing: trailingAnchor,
                      padding: UIEdgeInsets(top: 4, left: 777, bottom: 777, right: 4))
    avatarView.heightAnchor.constraint(equalTo: textField.heightAnchor, multiplier: 1).isActive = true
    avatarView.widthAnchor.constraint(equalTo: textField.heightAnchor, multiplier: 1).isActive = true
    //textField constraints
    
    textField.anchor(top: topAnchor,
                     leading: leadingAnchor,
                     bottom: bottomAnchor,
                     trailing: avatarView.leadingAnchor,
                     padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 12))
    
  }
  
  override var intrinsicContentSize: CGSize {
    return UIView.layoutFittingExpandedSize
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    avatarView.layer.masksToBounds = true
    avatarView.layer.cornerRadius = avatarView.frame.width / 2
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
