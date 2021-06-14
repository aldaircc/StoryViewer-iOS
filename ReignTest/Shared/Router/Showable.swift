//
//  Showable.swift
//  ReignTest
//
//  Created by Aldair Raul Cosetito Coral on 12/06/21.
//

import UIKit

protocol Showable {
    func toShowable() -> UIViewController
}

extension UIViewController: Showable {
    public func toShowable() -> UIViewController {
        return self
    }
}
