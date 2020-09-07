//
//  NewsfeedCell.swift
//  VkNewsFeed
//
//  Created by Анастасия Лагарникова on 03.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation
import UIKit

protocol FeedCellViewModel {
  var iconUrlString: String { get }
  var name: String { get }
  var date: String { get }
  var post: String? { get }
  var likes: String? { get }
  var comments: String? { get }
  var shares: String? { get }
  var views: String? { get }
  var photoAttachments: [FeedCellPhotoAttachmentViewModel] { get }
  var sizes: FeedCellSizes { get }
  
}

protocol FeedCellSizes {
  var postLabelFrame: CGRect { get }
  var attachmentFrame: CGRect { get }
  var bottomViewFrame: CGRect { get }
  var totalHeight: CGFloat { get }
  var moreTextButtonFrame: CGRect { get }
}

protocol FeedCellPhotoAttachmentViewModel {
  var photoUrlString: String? { get }
  var width: Int { get }
  var height: Int { get }
}

class NewsfeedCell: UITableViewCell {
  
  static let reuseId = "NewsfeedCell"
  
  @IBOutlet weak var iconImageView: WebImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var postLabel: UILabel!
  @IBOutlet weak var likesLabel: UILabel!
  @IBOutlet weak var commentsLabel: UILabel!
  @IBOutlet weak var sharesLabel: UILabel!
  @IBOutlet weak var viewsLabel: UILabel!
  @IBOutlet weak var postImageView: WebImageView!
  @IBOutlet weak var cardView: UIView!
  
  @IBOutlet weak var bottomView: UIView!
  
  override func prepareForReuse() {
    iconImageView.set(imageURL: nil)
    postImageView.set(imageURL: nil)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    cardView.layer.cornerRadius = 10
    cardView.clipsToBounds = true
    iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
    backgroundColor = .clear
    selectionStyle = .none
    

  }
  
//  func configure(viewModel: FeedCellViewModel) {
//    iconImageView.set(imageURL: viewModel.iconUrlString)
//    nameLabel.text = viewModel.name
//    dateLabel.text = viewModel.date
//    postLabel.text = viewModel.post
//    likesLabel.text = viewModel.likes
//    commentsLabel.text = viewModel.comments
//    sharesLabel.text = viewModel.shares
//    viewsLabel.text = viewModel.views
//    
//    postLabel.frame = viewModel.sizes.postLabelFrame
//    postImageView.frame = viewModel.sizes.attachmentFrame
//    bottomView.frame = viewModel.sizes.bottomViewFrame
//
//    if let photoAttachment = viewModel.photoAttachment {
//      postImageView.set(imageURL: photoAttachment.photoUrlString)
//      postImageView.isHidden = false
//    } else {
//      postImageView.isHidden = true
//    }
//  }
}
