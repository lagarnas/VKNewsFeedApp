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
  
  private var feedViewModel = FeedViewModel(cells: [])
  
  private var titleView = TitleView()
  
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
    
    //    tableVIew.register(UINib(nibName: "NewsfeedCell", bundle: nil), forCellReuseIdentifier: NewsfeedCell.reuseId)
    
    tableVIew.register(NewsfeedCodeCell.self, forCellReuseIdentifier: NewsfeedCodeCell.reuseId)
    
    tableVIew.backgroundColor = .clear
    view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    
    interactor?.makeRequest(request: .getNewsFeed)
  }
  
  private func setupTopBars() {
    self.navigationController?.hidesBarsOnSwipe = true
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationItem.titleView = titleView
  }
  
  func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData) {
    
    switch viewModel {
    case .dispayNewsFeed(feedViewModel: let feedViewModel):
      self.feedViewModel = feedViewModel
      tableVIew.reloadData()
    }
  }
}

extension NewsfeedViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    feedViewModel.cells.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //    let cell = tableView.dequeueReusableCell(withIdentifier: NewsfeedCell.reuseId, for: indexPath) as! NewsfeedCell
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
