//
//  NewsfeedViewController.swift
//  VkNewsFeed
//
//  Created by Анастасия Лагарникова on 03.09.2020.
//  Copyright (c) 2020 lagarnas. All rights reserved.
//

import UIKit

protocol NewsfeedDisplayLogic: class {
  func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData)
}

class NewsfeedViewController: UIViewController, NewsfeedDisplayLogic {
  
  @IBOutlet weak var tableVIew: UITableView!
  var interactor: NewsfeedBusinessLogic?
  var router: (NSObjectProtocol & NewsfeedRoutingLogic)?
  
  private var feedViewModel = FeedViewModel(cells: [], footerTitle: nil)
  
  private var titleView = TitleView()
  private lazy var footerView = FooterView()
  
  private var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    return refreshControl
  }()
  
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = NewsfeedInteractor()
    let presenter             = NewsfeedPresenter()
    let router                = NewsfeedRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    setupTopBars()
    setupTable()
    
    interactor?.makeRequest(request: .getNewsFeed)
    interactor?.makeRequest(request: .getUser)
  }
  
  private func setupTable() {
    let topInset: CGFloat = 8
    tableVIew.contentInset.top = topInset
    
    tableVIew.register(NewsfeedCodeCell.self, forCellReuseIdentifier: NewsfeedCodeCell.reuseId)
    tableVIew.separatorStyle = .none
    tableVIew.backgroundColor = .clear
    tableVIew.addSubview(refreshControl)
    tableVIew.tableFooterView = footerView
  }
  
  private func setupTopBars() {
    
    let topBar = UIView(frame: (UIApplication.shared.windows.first?.windowScene?.statusBarManager!.statusBarFrame)!)
    topBar.backgroundColor = .white
    topBar.layer.shadowColor = UIColor.black.cgColor
    topBar.layer.shadowOpacity = 0.3
    topBar.layer.shadowOffset = CGSize.zero
    topBar.layer.shadowRadius = 8
    self.view.addSubview(topBar)
    self.navigationController?.hidesBarsOnSwipe = true
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationItem.titleView = titleView
  }
  
  @objc func refresh() {
    interactor?.makeRequest(request: Newsfeed.Model.Request.RequestType.getNewsFeed)
  }
  
  func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData) {
    
    switch viewModel {
    case .dispayNewsFeed(feedViewModel: let feedViewModel):
      self.feedViewModel = feedViewModel
      footerView.setTitle(feedViewModel.footerTitle)
      tableVIew.reloadData()
      refreshControl.endRefreshing()
    case .displayUser(userViewModel: let userViewModel):
      titleView.set(userViewModel: userViewModel)
    case .displayFooterLoader:
      footerView.showLoader()
    }
  }
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if scrollView.contentOffset.y > scrollView.contentSize.height / 1.1 {
      interactor?.makeRequest(request: Newsfeed.Model.Request.RequestType.getNextBatch)
    }
  }
}

extension NewsfeedViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    feedViewModel.cells.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: NewsfeedCodeCell.reuseId, for: indexPath) as! NewsfeedCodeCell
    let cellViewModel = feedViewModel.cells[indexPath.row]
    cell.configure(viewModel: cellViewModel)
    cell.delegate = self
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let cellViewModel = feedViewModel.cells[indexPath.row]
    return cellViewModel.sizes.totalHeight
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    let cellViewModel = feedViewModel.cells[indexPath.row]
    return cellViewModel.sizes.totalHeight
  }
}

//MARK: - NewsfeedCodeCellDelegate
extension NewsfeedViewController: NewsfeedCodeCellDelegate {
  func revealPost(for cell: NewsfeedCodeCell) {
    print(#function)
    guard let indexPath = tableVIew.indexPath(for: cell) else { return }
    let cellViewModel = feedViewModel.cells[indexPath.row]
    interactor?.makeRequest(request: Newsfeed.Model.Request.RequestType.revealPost(postId: cellViewModel.postId))
  }
}
