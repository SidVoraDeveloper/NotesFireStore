//
//  DateExtension.swift
//  FluentFast
//
//  Created by Tecocraft on 22/01/21.
//

import Foundation
import UIKit

extension Date {
    
    func toString(format: String) -> String {
        
        let dateformatter = DateFormatter()
        
        dateformatter.dateFormat = format
        
        let dateString = dateformatter.string(from: self)
        
        return dateString
        
    }
}
