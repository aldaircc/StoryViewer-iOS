//
//  Router.swift
//  ReignTest
//
//  Created by Aldair Raul Cosetito Coral on 12/06/21.
//

import UIKit

protocol Router {
    var navigationController: UINavigationController { get }
    var rootViewController: UIViewController { get }
    func present(_ module: Showable, animated: Bool)
    func push(_ module: Showable, animated: Bool, completion: (() -> Void)?)
    func pop(_ animated: Bool)
}
