//
//  ErrorLabel.swift
//  ScorpCase
//
//  Created by Emre Büyüker on 17.08.2021.
//

import Foundation
import UIKit

class ErrorLabel: UILabel {
    @IBInspectable var localizableKey: String? = nil {
        didSet {
            if localizableKey != nil {
                self.text = NSLocalizedString(localizableKey!, comment: "")
            }
        }
    }
}
