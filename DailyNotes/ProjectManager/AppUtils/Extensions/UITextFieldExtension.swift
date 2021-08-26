//
//  UITextFieldExtension.swift
//  DailyNotes
//
//  Created by Tecocraft on 24/08/21.
//

import Foundation
import UIKit

extension UITextField {
    
    enum Direction {
        case Left
        case Right
    }
    
    /// add onliy icon
    func addIcon(direction: Direction, imageName: String, frame: CGRect = CGRect(x: 0, y: 0, width: 20, height: 20), backgroundColor: UIColor = UIColor.clear) {
        
        let View = UIView(frame: frame)
        View.backgroundColor = backgroundColor

        let imageView = UIImageView(frame: frame)
        imageView.contentMode = .center
        imageView.image = UIImage(named: imageName)

        View.addSubview(imageView)

        if Direction.Left == direction {
            
            self.leftViewMode = .always
            self.leftView = View
        } else {
            
            self.rightViewMode = .always
            self.rightView = View
            
        }
        
    }
    
    /// toggle password
    func enablePasswordToggle(frame: CGRect = CGRect(x: 0, y: 0, width: 20, height: 20), insets: UIEdgeInsets = UIEdgeInsets(top: -4, left: -4, bottom: -4, right: -4)) {
        
        let button = UIButton(type: .custom)
        button.imageEdgeInsets = insets
        button.frame = frame
        let imageIconName =  isSecureTextEntry ?  "ic_open_eye" : "ic_close_eye"
        button.setImage(UIImage(named: imageIconName), for: .normal)
       
        button.addTarget(self, action: #selector(self.togglePasswordView(_ :)), for: .touchUpInside)
        self.rightView = button
        self.rightViewMode = .always
        
    }
    
    @objc func togglePasswordView(_ sender: UIButton) {
        
        self.isSecureTextEntry = !self.isSecureTextEntry
        let imageIconName =  isSecureTextEntry ?  "ic_open_eye" : "ic_close_eye"
        sender.setImage(UIImage(named: imageIconName), for: .normal)
        
    }
    
}
