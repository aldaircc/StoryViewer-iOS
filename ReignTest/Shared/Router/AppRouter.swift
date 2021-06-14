//
//  AppRouter.swift
//  ReignTest
//
//  Created by Aldair Raul Cosetito Coral on 12/06/21.
//

import UIKit

class AppRouter: NSObject, Router {
    
    private var completions: [UIViewController: () -> Void]
    var navigationController: UINavigationController
    var rootViewController: UIViewController {
        return navigationController.viewControllers.first!
    }
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.completions = [:]
        super.init()
    }
    
    func toShowable() -> UIViewController {
        return navigationController
    }
    
    func present(_ module: Showable, animated: Bool) {
        navigationController.present(module.toShowable(), animated: animated, completion: nil)
    }
    
    func push(_ module: Showable, animated: Bool, completion: (() -> Void)?) {
        let controller = module.toShowable()
        
        guard controller is UINavigationController == false else {
            return
        }
        
        if let completion = completion {
            self.completions[controller] = completion
        }
        
        self.navigationController.pushViewController(controller, animated: animated)    
    }
    
    func pop(_ animated: Bool) {
        if let module = self.navigationController.popViewController(animated: animated) {
            runCompletion(module)
        }
    }
    
    func runCompletion(_ module: UIViewController) {
        guard let completion = self.completions[module] else {
            return
        }
        completion()
        self.completions.removeValue(forKey: module)
    }
}
