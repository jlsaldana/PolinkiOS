//
//  SceneDelegate.swift
//  Polink
//
//  Created by Jose Saldana on 01/02/2020.
//  Copyright © 2020 Jose Saldana. All rights reserved.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	
	var window: UIWindow?
	var navigationController: UINavigationController?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		// Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
		// If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
		// This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
		guard let myScene = (scene as? UIWindowScene) else { return }
		
		window = UIWindow(windowScene: myScene)
		if let window = window {
			
			if Auth.auth().currentUser != nil {
				let mainVC = TabBarController()
				navigationController = UINavigationController(rootViewController: mainVC)
				
				print("is logged in")
				navigationController?.setNavigationBarHidden(true, animated: false)
				navigationController?.isToolbarHidden = true
				window.rootViewController = navigationController
				window.makeKeyAndVisible()
			} else {
				let mainVC = InitialViewController()
				navigationController = UINavigationController(rootViewController: mainVC)
				
				navigationController?.setToolbarHidden(true, animated: false)
				navigationController?.setNavigationBarHidden(true, animated: false)
				print("making window main")
				window.rootViewController = navigationController
				window.makeKeyAndVisible()
			}
			
//			if UserDefaults.standard.bool(forKey: "LOGGED_IN") {
//				let mainVC = TabBarController()
//				navigationController = UINavigationController(rootViewController: mainVC)
//				
//				print("is logged in")
//				navigationController?.setNavigationBarHidden(true, animated: false)
//				navigationController?.isToolbarHidden = true
//				window.rootViewController = navigationController
//				window.makeKeyAndVisible()
//			} else {
//				// If the user token is not logged in...
////				let mainSB = UIStoryboard(name: "Main", bundle: nil)
////				let mainVC = mainSB.instantiateViewController(withIdentifier: "initialViewController") as! InitialVC
//				let mainVC = InitialViewController()
//				navigationController = UINavigationController(rootViewController: mainVC)
//				
//				navigationController?.setToolbarHidden(true, animated: false)
//				navigationController?.setNavigationBarHidden(true, animated: false)
//				print("making window main")
//				window.rootViewController = navigationController
//				window.makeKeyAndVisible()
//			}
		}
	}
	
	func sceneDidDisconnect(_ scene: UIScene) {
		// Called as the scene is being released by the system.
		// This occurs shortly after the scene enters the background, or when its session is discarded.
		// Release any resources associated with this scene that can be re-created the next time the scene connects.
		// The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
	}
	
	func sceneDidBecomeActive(_ scene: UIScene) {
		// Called when the scene has moved from an inactive state to an active state.
		// Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
	}
	
	func sceneWillResignActive(_ scene: UIScene) {
		// Called when the scene will move from an active state to an inactive state.
		// This may occur due to temporary interruptions (ex. an incoming phone call).
	}
	
	func sceneWillEnterForeground(_ scene: UIScene) {
		// Called as the scene transitions from the background to the foreground.
		// Use this method to undo the changes made on entering the background.
	}
	
	func sceneDidEnterBackground(_ scene: UIScene) {
		// Called as the scene transitions from the foreground to the background.
		// Use this method to save data, release shared resources, and store enough scene-specific state information
		// to restore the scene back to its current state.
	}
	
	
}

