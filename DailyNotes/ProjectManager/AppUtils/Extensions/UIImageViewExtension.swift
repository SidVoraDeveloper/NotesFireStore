//
//  UIImageViewExtension.swift
//  FluentFast
//
//  Created by Tecocraft on 29/06/21.
//

import Foundation
import UIKit

extension UIImageView {

    func setupRoundedImage(borderWidth:CGFloat = 0, borderColor: UIColor = .clear, cornerRadius: CGFloat = 0) {
        self.layer.borderWidth = borderWidth
        self.layer.masksToBounds = false
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
    
    func setImageTintColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
      }
}
