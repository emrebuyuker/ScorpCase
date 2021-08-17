//
//  UIViewControllerExtensions.swift
//  ScorpCase
//
//  Created by Emre Büyüker on 17.08.2021.
//

import Foundation
import UIKit

public extension UIViewController {
    func localizableGetString(forkey: String) -> String {
        let string = NSLocalizedString(forkey, comment: "")
        return string
    }
}
