//
//  SceneDelegate.swift
//  BLM
//
//  Created by Jonathan Misael Rivera on 11/08/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: Coordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)

        let navController = UINavigationController()
        coordinator = Coordinator(navigationController: navController)
        coordinator?.start()

        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }

}

