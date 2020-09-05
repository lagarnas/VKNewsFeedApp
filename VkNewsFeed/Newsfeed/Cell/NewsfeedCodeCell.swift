//
//  NewsfeedCodeCell.swift
//  VkNewsFeed
//
//  Created by Анастасия Лагарникова on 04.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation
import UIKit

protocol NewsfeedCodeCellDelegate: class {
  func revealPost(for cell: NewsfeedCodeCell)
}

final class NewsfeedCodeCell: UITableViewCell {
  
  static let reuseId = "NewsfeedCodeCell"
  
  weak var delegate: NewsfeedCodeCellDelegate?
  
  //1-й слой
  let cardView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  //2-й слой
  let topView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let postLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.font = Constants.postLabelFont
    label.textColor = #colorLiteral(red: 0.227329582, green: 0.2323184013, blue: 0.2370472848, alpha: 1)
    return label
  }()
  
  let moreTextButton: UIButton = {
    let buttom = UIButton()
    buttom.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
    buttom.setTitleColor(#colorLiteral(red: 0.4, green: 0.6235294118, blue: 0.831372549, alpha: 1), for: .normal)
    buttom.contentHorizontalAlignment = .left
    buttom.contentVerticalAlignment = .center
    buttom.setTitle("Показать полностью...", for: .normal)
    return buttom
  }()
  
  let postImageView: WebImageView = {
    let postImageView = WebImageView()
    return postImageView
  }()
  
  let bottomView: UIView = {
    let view = UIView()
    return view
  }()
  
  //3-й слой на topView
  let iconImageView: WebImageView = {
    let imageView = WebImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    label.numberOfLines = 0
    label.textColor = #colorLiteral(red: 0.227329582, green: 0.2323184013, blue: 0.2370472848, alpha: 1)
    return label
  }()
  
  let dateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 12)
    label.numberOfLines = 0
    label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
    return label
  }()
  
  //3-й слой на bottomView
  let likesView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let commentsView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let sharesView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let viewsView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  //4-й слой на bottomView
  let likesImage: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "like")
    return imageView
  }()
  
  let commentsImage: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "comment")
    return imageView
  }()
  
  let sharesImage: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "share")
    return imageView
  }()
  
  let viewsImage: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "eye")
    return imageView
  }()
  
  let likesLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
    label.lineBreakMode = .byClipping
    return label
  }()
  
  let commentsLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
    label.lineBreakMode = .byClipping
    return label
  }()
  
  let sharesLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
    label.lineBreakMode = .byClipping
    return label
  }()
  
  let viewsLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
    label.lineBreakMode = .byClipping
    return label
  }()
  
  
  //MARK: - Init
  override func prepareForReuse() {
    iconImageView.set(imageURL: nil)
    postImageView.set(imageURL: nil)
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    backgroundColor = .clear
    selectionStyle = .none
    iconImageView.layer.cornerRadius = Constants.topViewHeight / 2
    iconImageView.clipsToBounds = true
    
    cardView.layer.cornerRadius = 10
    cardView.clipsToBounds = true
    
    moreTextButton.addTarget(self, action: #selector(moreTextButtonTouch), for: .touchUpInside)
    
    overlaAllLayers()
    
  }
  
  @objc private func moreTextButtonTouch() {
    delegate?.revealPost(for: self)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Configure cell
  func configure(viewModel: FeedCellViewModel) {
    iconImageView.set(imageURL: viewModel.iconUrlString)
    nameLabel.text = viewModel.name
    dateLabel.text = viewModel.date
    postLabel.text = viewModel.post
    likesLabel.text = viewModel.likes
    commentsLabel.text = viewModel.comments
    sharesLabel.text = viewModel.shares
    viewsLabel.text = viewModel.views
    
    
    postLabel.frame = viewModel.sizes.postLabelFrame
    postImageView.frame = viewModel.sizes.attachmentFrame
    bottomView.frame = viewModel.sizes.bottomViewFrame
    moreTextButton.frame = viewModel.sizes.moreTextButtonFrame
    if let photoAttachment = viewModel.photoAttachment {
      postImageView.set(imageURL: photoAttachment.photoUrlString)
      postImageView.isHidden = false
    } else {
      postImageView.isHidden = true
    }
  }
}

//MARK: - Overlay layers
extension NewsfeedCodeCell {
  
  private func overlaAllLayers() {
    overlayFirstLayer() // первый слой
    overlaySecondLayer() // второй слой
    overlayThirdLayerOnTopView() // третий слой на topView
    overlayThirdLayerOnBottomView() // третий слой на bottomView
    overlayFourthLayerOnBottomView() // четвертый слой на bottomView
  }
  
  private func overlayFourthLayerOnBottomView() {
    likesView.addSubview(likesImage)
    likesView.addSubview(likesLabel)
    
    commentsView.addSubview(commentsImage)
    commentsView.addSubview(commentsLabel)
    
    sharesView.addSubview(sharesImage)
    sharesView.addSubview(sharesLabel)
    
    viewsView.addSubview(viewsImage)
    viewsView.addSubview(viewsLabel)
    
    helpInFourthLayer(view: likesView, imageView: likesImage, label: likesLabel)
    helpInFourthLayer(view: commentsView, imageView: commentsImage, label: commentsLabel)
    helpInFourthLayer(view: sharesView, imageView: sharesImage, label: sharesLabel)
    helpInFourthLayer(view: viewsView, imageView: viewsImage, label: viewsLabel)
  }
  
  private func helpInFourthLayer(view: UIView, imageView: UIImageView, label: UILabel) {
    
    // imageView constraints
    imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
    imageView.widthAnchor.constraint(equalToConstant: Constants.bottomViewViewsIconSize).isActive = true
    imageView.heightAnchor.constraint(equalToConstant: Constants.bottomViewViewsIconSize).isActive = true
    
    // label constraints
    label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4).isActive = true
    label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    
  }
  
  private func overlayThirdLayerOnBottomView() {
    bottomView.addSubview(likesView)
    bottomView.addSubview(commentsView)
    bottomView.addSubview(sharesView)
    bottomView.addSubview(viewsView)
    
    // likesView constraints
    likesView.anchor(top: bottomView.topAnchor,
                     leading: bottomView.leadingAnchor,
                     bottom: nil,
                     trailing: nil,
                     size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewHeight))
    // commentsView constraints
    commentsView.anchor(top: bottomView.topAnchor,
                        leading: likesView.trailingAnchor,
                        bottom: nil,
                        trailing: nil,
                        size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewHeight))
    // sharesView constraints
    sharesView.anchor(top: bottomView.topAnchor,
                      leading: commentsView.trailingAnchor,
                      bottom: nil,
                      trailing: nil,
                      size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewHeight))
    
    // viewsView constraints
    viewsView.anchor(top: bottomView.topAnchor,
                     leading: nil,
                     bottom: nil,
                     trailing: bottomView.trailingAnchor,
                     size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewHeight))
  }
  
  private func overlayThirdLayerOnTopView() {
    topView.addSubview(iconImageView)
    topView.addSubview(nameLabel)
    topView.addSubview(dateLabel)
    
    // iconImageView constraints
    iconImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
    iconImageView.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
    iconImageView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
    iconImageView.widthAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
    // nameLabel constraints
    nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
    nameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
    nameLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 2).isActive = true
    nameLabel.heightAnchor.constraint(equalToConstant: Constants.topViewHeight / 2 - 2).isActive = true
    
    // dateLabel constraints
    dateLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
    dateLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
    dateLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -2).isActive = true
    dateLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
  }
  
  private func overlaySecondLayer() {
    cardView.addSubview(topView)
    cardView.addSubview(postLabel)
    cardView.addSubview(moreTextButton)
    cardView.addSubview(postImageView)
    cardView.addSubview(bottomView)
    
    //topView constraints
    topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8).isActive = true
    topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8).isActive = true
    topView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8).isActive = true
    topView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
    
    // moreTextButton constraints
    
  }
  
  private func overlayFirstLayer() {
    addSubview(cardView)
    //cardView constraints
    cardView.fillSuperview(padding: Constants.cardInsets)
  }
}
