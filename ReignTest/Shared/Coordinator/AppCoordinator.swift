//
//  AppCoordinator.swift
//  ReignTest
//
//  Created by Aldair Raul Cosetito Coral on 12/06/21.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    //MARK: - Local variables
    let window: UIWindow
    let rootViewController: UINavigationController
    let appRouter: AppRouter
    let storyCoordinator: StoryCoordinator
    
    //MARK: - Initializer
    init(_ window: UIWindow) {
        self.window = window
        self.rootViewController = UINavigationController()
        self.rootViewController.navigationBar.prefersLargeTitles = false
        self.appRouter = AppRouter(rootViewController)
        self.storyCoordinator = StoryCoordinator(self.appRouter)
    }
    
    //MARK: - Methods
    func start() {
        window.rootViewController = appRouter.toShowable()
        self.storyCoordinator.start()
        window.makeKeyAndVisible()
    }
}
