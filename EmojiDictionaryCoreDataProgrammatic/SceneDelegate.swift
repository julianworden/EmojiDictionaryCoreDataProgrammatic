//
//  SceneDelegate.swift
//  EmojiDictionaryCoreDataProgrammatic
//
//  Created by Julian Worden on 7/21/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let navigationController = UINavigationController(rootViewController: MainViewController())
        navigationController.navigationBar.tintColor = .black

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

