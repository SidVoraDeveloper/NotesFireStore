//
//  UILabelExtension.swift
//  FluentFast
//
//  Created by Tecocraft on 29/06/21.
//

import Foundation
import UIKit

extension UILabel {
    
    func setupLabel(title: String, fontSize: UIFont, textColor: UIColor = .clear) {
        if title != "" {
            self.text = title
        }
        self.font = fontSize
        self.textColor = textColor
    }
}
