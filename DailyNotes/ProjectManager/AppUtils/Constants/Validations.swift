//
//  Validations.swift
//  FluentFast
//
//  Created by Tecocraft on 18/01/21.
//

import Foundation
import UIKit

class Validations {
    
    //Function is used to check whether email is valid or not
    func isValidEmail(_ sEmail:String) ->Bool {
        let emailRegEx = "^(?![0-9]+@)([A-Za-z0-9._%+-\\.-]+)@([a-z.-]+)\\.([a-z\\.]{2,6})$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: sEmail)
    }
    
    //Function is used to check whether password is valid or not
    func isValidatePassword(sPassword:String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{6,}")
        return passwordTest.evaluate(with: sPassword)
    }
    
    //Funcation is used to check whether username is valid or not
    func isValidUserName(_ sUserName:String) ->Bool {
        let userNameRegEx = "[a-zA-Z 0-9]+"
        let userNameTest = NSPredicate(format:"SELF MATCHES %@", userNameRegEx)
        return userNameTest.evaluate(with: sUserName)
    }
    
    //Funcation is used to check whether mendatory field is not empty
    func isFieldEmpty(_ txtField:String) ->Bool {
        return txtField == "" ? true : false
    }
}
