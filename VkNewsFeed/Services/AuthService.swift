//
//  AuthService.swift
//  VkNewsFeed
//
//  Created by Анастасия Лагарникова on 02.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import Foundation
import VKSdkFramework

protocol AuthServiceDelegate: class {
  
  func authServiceShouldShow(viewController: UIViewController)
  func authServiceSignIn()
  func authServiceSignInDidFail()
}

class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
  
  private let appId = "7585168"
  private let vkSdk: VKSdk
  
  override init() {
    vkSdk = VKSdk.initialize(withAppId: appId)
    super.init()
    print("VKSdk.initialize")
    vkSdk.register(self)
    vkSdk.uiDelegate = self
  }
  
  weak var delegate: AuthServiceDelegate?
  
  var token: String? {
    return VKSdk.accessToken()?.accessToken
  }
  
  var userId: String? {
    return VKSdk.accessToken()?.userId
  }
  
  func wakeUpSession() {
    let scope = ["wall", "friends"]
    VKSdk.wakeUpSession(scope) { [delegate] (state, error) in
      switch state {
      case .initialized:
        print("initialized")
        VKSdk.authorize(scope)
      case .authorized:
        print("authorized")
        delegate?.authServiceSignIn()
      default:
        delegate?.authServiceSignInDidFail()
      }
    }
  }
  
  
  func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
    print(#function)
    if result.token != nil {
      delegate?.authServiceSignIn()
    }
  
  }
  
  func vkSdkUserAuthorizationFailed() {
    print(#function)
    delegate?.authServiceSignInDidFail()
  }
  
  func vkSdkShouldPresent(_ controller: UIViewController!) {
    print(#function)
    delegate?.authServiceShouldShow(viewController: controller)
  }
  
  func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
    print(#function)
  }
}
