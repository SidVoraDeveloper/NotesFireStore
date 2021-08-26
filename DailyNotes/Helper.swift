//
//  Helper.swift
//  localizationDemo
//
//  Created by Neel Patel on 25/08/21.
//

import Foundation
import UIKit

// MARK: - Language Name
func saveLanguageCode(languageCode: String) {
    UserDefaults.standard.set(languageCode, forKey: "LANGUAGE_CODE")
}
func getLanguageCode() -> String {
    return UserDefaults.standard.string(forKey: "LANGUAGE_CODE") ?? "en"
}
func getSelLanguage() -> LanguageDict
{
    let selLang = getLanguageCode()
    let selLanguage = LanguageArray.filter({$0.languageCode == selLang})
    if selLanguage.count > 0
    {
        return selLanguage[0]
    }
    return LanguageDict(languageName: "English", languageCode: "en")
}
func getLocalizedString(key: String) -> String {
    let languageCode = getLanguageCode()
    if let path = Bundle.main.path(forResource: languageCode, ofType: "lproj") {
        let bundle = Bundle(path: path)
        return NSLocalizedString(key, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    return NSLocalizedString(key, comment: "")
}
func getLocalizedString(key: LocalizedString) -> String {
    return getLocalizedString(key: key.rawValue)
}

func showValidationAlert(title: String, message: String) {
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    
    alert.addAction(UIAlertAction(title: getLocalizedString(key: .ok), style: UIAlertAction.Style.default, handler: nil))
    
//    let keyWindow = UIApplication.shared.connectedScenes
//            .filter({$0.activationState == .foregroundActive})
//            .compactMap({$0 as? UIWindowScene})
//            .first?.windows
//            .filter({$0.isKeyWindow}).first
    
    var rootViewController = sKeyWindow?.rootViewController
    
    if let navigationController = rootViewController as? UINavigationController {
        rootViewController = navigationController.viewControllers.first
    }
    
    rootViewController?.present(alert, animated: true, completion: nil)
}
