//
//  ViewController.swift
//  VkNewsFeed
//
//  Created by Анастасия Лагарникова on 02.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
  
  private var authService: AuthService!

  override func viewDidLoad() {
    super.viewDidLoad()
    authService = SceneDelegate.shared().authService
    view.backgroundColor = .red
  }

  @IBAction func signInToch(_ sender: UIButton) {
    authService.wakeUpSession()
  }
  
}

