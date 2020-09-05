//
//  SceneDelegate.swift
//  VkNewsFeed
//
//  Created by Анастасия Лагарникова on 02.09.2020.
//  Copyright © 2020 lagarnas. All rights reserved.
//

import UIKit
import VKSdkFramework

class SceneDelegate: UIResponder, UIWindowSceneDelegate, AuthServiceDelegate {
  
  var window: UIWindow?
  
  var authService: AuthService!
  
  static func shared() -> SceneDelegate {
    let scene = UIApplication.shared.connectedScenes.first
    let sceneDelegate: SceneDelegate = ((scene?.delegate as? SceneDelegate)!)
    return sceneDelegate
  }
  
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    window = UIWindow(frame: windowScene.coordinateSpace.bounds)
    window?.windowScene = windowScene
    
    authService = AuthService()
    authService.delegate = self
    
    let authVC = UIStoryboard(name: "AuthViewController", bundle: nil).instantiateInitialViewController() as? AuthViewController
    window?.rootViewController = authVC
    window?.makeKeyAndVisible()
  }
  
  func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    if let url = URLContexts.first?.url {
      VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
    }
  }
  
  
  //MARK: - AuthServiceDelegate
  func authServiceShouldShow(viewController: UIViewController) {
    print(#function)
    window?.rootViewController?.present(viewController, animated: true, completion: nil)
    
  }
  
  func authServiceSignIn() {
    print(#function)
    
    let feedVC = UIStoryboard(name: "NewsfeedViewController", bundle: nil).instantiateInitialViewController() as! NewsfeedViewController
    
    let navVC = UINavigationController(rootViewController: feedVC)
    window?.rootViewController = navVC
    
  }
  
  func authServiceSignInDidFail() {
    print(#function)
  }
}

