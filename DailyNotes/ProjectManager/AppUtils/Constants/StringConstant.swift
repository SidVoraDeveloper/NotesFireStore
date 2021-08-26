//
//  StringConstant.swift
//  DailyNotes
//
//  Created by Tecocraft on 24/08/21.
//

import Foundation
import UIKit

enum errorValidationMessage: String {
    
    case fullNameMandatory = "Fullname is mandatory"
    
    case emailIDMandatory = "Email address is mandatory"
    case validEmailId = "Invalid email address"
    
    case passwordMandatory = "Password is mandatory"
    case validpassword = "Password must include atleast 1 uppercase alphabetic character, number, special character and must be atleast 6 characters long"
    
    case confirmPasswordMandatory = "Confirm password is mandatory"
    case confirmPasswordLength = "Confirm password needs to be at least 6 characters long"
    case confirmPasswordMatch = "Password & confirm password must be same"
    case profileImageMandatory = "Image is mandatory"
    
    case invalidEmailPassword = "Invalid Email or Password"
    
    case AreYouSureLogout = "Are you sure you want to logout?"
    
    case AreYouSureDelete = "Are you sure you want to delete?"
    
    var string : String {
        return self.rawValue
    }
}

struct dbField
{
    static let kdbUsers = "users"
    static let kdbNotes = "notes"
    static let kdbTimestamp = "timestamp"
    static let kdbTitle = "title"
    static let kdbImage = "image"
}
