//
//  UIFontConstant.swift
//  FluentFast
//
//  Created by Tecocraft on 29/06/21.
//

import Foundation
import UIKit

func fontSizeSeprated(size: CGFloat) -> CGFloat{
    if iPhone4_i5 {
        return size - 2.0 // 1.5
    }else if iPhone8_iX_iXs_i11pro {
        return size - 1.0
    }else if iPhone8pluse_iXR_i11_iMax {
        return size
    } else {
        return size + 1.5
    }
}

enum AppFont : CGFloat {
    case size7 = 7.0
    case size8 = 8.0
    case size9 = 9.0
    case size10 = 10.0
    case size11 = 11.0
    case size12 = 12.0
    case size13 = 13.0
    case size14 = 14.0
    case size15 = 15.0
    case size16 = 16.0
    case size17 = 17.0
    case size18 = 18.0
    case size19 = 19.0
    case size20 = 20.0
    case size21 = 21.0
    case size22 = 22.0
    case size23 = 23.0
    case size24 = 24.0
    case size25 = 25.0
    case size26 = 26.0
    case size27 = 27.0
    case size28 = 28.0
    case size29 = 29.0
    case size30 = 30.0
    case size31 = 31.0
    case size32 = 32.0
    case size33 = 33.0
    case size34 = 34.0
    case size35 = 35.0
    case size36 = 36.0
    case size37 = 37.0
    case size38 = 38.0
    case size39 = 39.0
    case size40 = 40.0
    case size41 = 41.0
    case size42 = 42.0
    case size43 = 43.0
    case size44 = 44.0
    case size45 = 45.0
    case size46 = 46.0
    case size47 = 47.0
    case size48 = 48.0
    case size49 = 49.0
    case size50 = 50.0
    
    var regular : UIFont {
        return UIFont.systemFont(ofSize: self.rawValue)
    }
    
    var bold : UIFont {
        return UIFont.systemFont(ofSize: self.rawValue, weight: .bold)
    }
    
    var semibold : UIFont {
        return UIFont.systemFont(ofSize: self.rawValue, weight: .semibold)
    }
    
}
