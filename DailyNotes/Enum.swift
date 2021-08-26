//
//  Enum.swift
//  localizationDemo
//
//  Created by Neel Patel on 25/08/21.
//

import Foundation


enum LocalizedString: String {
    
    //Login
    case logIn                          = "Login"
    case emailAddress                   = "EmailAddress"
    case enterEmailAddress              = "EnterEmailAddress"
    case password                       = "Password"
    case enterPassword                  = "EnterPassword"
    case dontHaveAnAccount              = "DontHaveAnAccount"
    case signUp                         = "Signup"
    
    //Signup
    case fullName                        = "fullName";
    case enterFullName                   = "enterFullName";
    case confirmPassword                 = "confirmPassword";
    case enterConfirmPassword            = "enterConfirmPassword";
    case alreadyHaveAnAccount            = "alreadyHaveAnAccount";
    
    //NotesList
    case notesList                       = "notesList";
    case addNotes                        = "addNotes";
    case addImage                        = "addImage";
    case description                     = "description";
    case addItem                         = "addItem";
    
    //Dialog Strings
    case fullNameMandatory               = "fullNameMandatory";
    case emailIDMandatory                = "emailIDMandatory";
    case validEmailId                    = "validEmailId";
    case passwordMandatory               = "passwordMandatory";
    case validpassword                   = "validpassword";
    case confirmPasswordMandatory        = "confirmPasswordMandatory";
    case confirmPasswordLength           = "confirmPasswordLength";
    case confirmPasswordMatch            = "confirmPasswordMatch";
    case profileImageMandatory           = "profileImageMandatory";
    case invalidEmailPassword            = "invalidEmailPassword";
    case AreYouSureLogout                = "AreYouSureLogout";
    case areYouSureDelete                = "areYouSureDelete";
    case yes                             = "yes";
    case no                              = "no";
    case cancel                          = "cancel";
    case pleaseAddImage                  = "pleaseAddImage";
    case pleaseAddDescription            = "pleaseAddDescription";
    case ok                              = "ok";
}
