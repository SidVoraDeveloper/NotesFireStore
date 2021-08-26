//
//  ThemeView.swift
//  FluentFast
//
//  Created by Tecocraft on 31/12/20.
//

import UIKit

class ThemeView: UIView {
    
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
    
    func sharedInit(){
        self.layer.borderWidth = 2.0
        self.layer.borderColor = sColorOrange.cgColor
        self.layer.cornerRadius = 5.0
    }
}
