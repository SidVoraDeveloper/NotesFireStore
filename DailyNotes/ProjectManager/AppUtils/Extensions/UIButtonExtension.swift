//
//  UIButtonExtension.swift
//  FluentFast
//
//  Created by Tecocraft on 29/06/21.
//

import Foundation
import UIKit

extension UIButton {
        
    func setUpButton(title : String, textColor : UIColor,borderColor:UIColor = UIColor.clear, fontSize : UIFont, bgColor : UIColor = .clear, cornerRadius : CGFloat = 0 ,borderWidth:CGFloat = 0 ){
        self.setTitle(title, for: .normal)
        self.backgroundColor = bgColor
        self.setTitleColor(textColor, for: .normal)
        self.titleLabel?.font = fontSize
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.clipsToBounds = true
    }
    
    func setupRoundedButton(borderWidth:CGFloat = 0, borderColor: UIColor = .clear, cornerRadius: CGFloat = 0, bgColor : UIColor = .clear) {
        self.layer.borderWidth = borderWidth
        self.backgroundColor = bgColor
        self.layer.masksToBounds = false
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
}
