//
//  ThemeTextField.swift
//  FluentFast
//
//  Created by Tecocraft on 31/12/20.
//

import UIKit

class ThemeTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    func sharedInit() {
        self.font = AppFont.size17.regular
        self.textColor = sColorWhite
    }
}
