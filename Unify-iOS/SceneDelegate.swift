//
//  SceneDelegate.swift
//  Unify-iOS
//
//  Created by Melvin Asare on 19/10/2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            self.window = window
            window.makeKeyAndVisible()
            window.rootViewController = UINavigationController(rootViewController: HomeViewController(viewModel: HomeViewModel()))
        }
    }
}
