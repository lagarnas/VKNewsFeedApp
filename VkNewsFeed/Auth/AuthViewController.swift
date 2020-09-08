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

      // Do any additional setup after loading the view.
      //authService = AuthService()
      authService = AppDelegate.shared().authService
  }

  @IBAction func signInToch(_ sender: UIButton) {
    authService.wakeUpSession()
  }
  
}

