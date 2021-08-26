//
//  LoginVC.swift
//  DailyNotes
//
//  Created by Tecocraft on 23/08/21.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {

    //MARK:- IB_OUTLETS
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var headerLbl: UILabel!
    
    @IBOutlet weak var chooseLanguageBtn: UIButton!
    
    @IBOutlet weak var emailLbl: ThemeTitleLabel!
    @IBOutlet weak var emailView: ThemeView!
    @IBOutlet weak var emailTF: ThemeTextField!
    
    @IBOutlet weak var passwordLbl: ThemeTitleLabel!
    @IBOutlet weak var passwordView: ThemeView!
    @IBOutlet weak var passwordTF: ThemeTextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var signUpLbl: UILabel!
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBOutlet weak var chooseLanguageTF: UITextField!
    
    //MARK:- DECLARATION
    
    
    
    //MARK:- VIEW_METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupView()
//        setTranslatedText()
        
        sLoaderView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        sKeyWindow?.addSubview(sLoaderView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setTranslatedText()
    }
    
    private func setupView() {
                
        // Do not allow to swipe back in login screen
        guard let navigationController = self.navigationController else { return }
        var navigationArray = navigationController.viewControllers // To get all UIViewController stack as Array
        let temp = navigationArray.last
        navigationArray.removeAll()
        navigationArray.append(temp!) //To remove all previous UIViewController except the last one
        self.navigationController?.viewControllers = navigationArray
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.view.backgroundColor = sColorDarkGray
        
        contentView.backgroundColor = sColorDarkGray
        
        self.chooseLanguageBtn.titleLabel?.lineBreakMode = .byCharWrapping
        
        self.chooseLanguageBtn.layer.backgroundColor = sColorOrange.cgColor
        
        self.chooseLanguageBtn.titleLabel?.textAlignment = .center
        
        self.chooseLanguageBtn.layer.cornerRadius = 5.0
        
        self.passwordTF.isSecureTextEntry = true
        
        self.passwordTF.enablePasswordToggle()
        
        // Dismiss Keyboard when outside of Textfield Click
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        chooseLanguageBtn.addTarget(self, action: #selector(chooseLanguageBtnClick(sender:)), for: .touchUpInside)
        
        loginBtn.addTarget(self, action: #selector(loginBtnClicked(sender:)), for: .touchUpInside)
        
        signUpBtn.addTarget(self, action: #selector(signupBtnClicked(sender:)), for: .touchUpInside)
    }
    
    
    //MARK:- IB_ACTION
    @objc func loginBtnClicked(sender: UIButton) {
        
        if checkTextFieldValidations() {
            
            self.view.endEditing(true)
            
            sLoaderView.startAnimating()
            
            Auth.auth().signIn(withEmail: emailTF.text ?? "" , password: passwordTF.text ?? "") { authResult, error in
                
                sLoaderView.stopAnimating()
                
                if authResult != nil { //Successfully Login
                    self.performSegue(withIdentifier: "showNotesListVC", sender: self)
                    
                } else { // User account is not found in database
                    showValidationAlert(title: "", message: error?.localizedDescription ?? "")
                }
            }
        }
    }
    
    @objc private func signupBtnClicked(sender: UIButton) {
        self.performSegue(withIdentifier: "showSignupVC", sender: self)
    }
    
    @objc private func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @objc private func chooseLanguageBtnClick(sender: UIButton) {
        
        var actionSheet: UIAlertController!
        
        actionSheet = UIAlertController(title: nil, message: "Choose Language", preferredStyle: UIAlertController.Style.actionSheet)
                
        for language in LanguageArray {
            
            let languageAction = UIAlertAction(title: language.languageName, style: .default, handler: {(alert: UIAlertAction!) -> Void in
                
                let myNormalAttributedTitle = NSAttributedString(string: language.languageName, attributes: [
                                                                    NSAttributedString.Key.font : AppFont.size15.semibold,
                                                                    NSAttributedString.Key.foregroundColor : sColorWhite])
                
                self.chooseLanguageBtn.setAttributedTitle(myNormalAttributedTitle, for: .normal)
                
                saveLanguageCode(languageCode: language.languageCode)
                
                self.setTranslatedText()
            })
            
            actionSheet.addAction(languageAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: {
            (alert: UIAlertAction) -> Void in
        })
        
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    
    //MARK:- OTHER_METHODS
    private func checkTextFieldValidations() -> Bool {
        
        if Validations().isFieldEmpty(emailTF.text ?? "")
        {
            showValidationAlert(title: "", message: getLocalizedString(key: .emailIDMandatory))
            return false
        }
        else
        {
            if Validations().isValidEmail(emailTF.text ?? "") == false {
                showValidationAlert(title: "", message: getLocalizedString(key: .validEmailId))
                return false
            }
        }
        
        if Validations().isFieldEmpty(passwordTF.text ?? "")
        {
            showValidationAlert(title: "", message: getLocalizedString(key: .passwordMandatory))
            return false
        }
        
        return true
    }
    
    private func setTranslatedText() {
        
        let language = getSelLanguage()
        let myNormalAttributedTitle = NSAttributedString(string: language.languageName, attributes: [
                                                            NSAttributedString.Key.font : AppFont.size15.semibold,
                                                            NSAttributedString.Key.foregroundColor : sColorWhite])
        
        self.chooseLanguageBtn.setAttributedTitle(myNormalAttributedTitle, for: .normal)
        
        
        self.headerLbl.setupLabel(title: getLocalizedString(key: .logIn).uppercased(), fontSize: AppFont.size30.bold, textColor: sColorYellow)
        
        self.emailLbl.text = getLocalizedString(key: .emailAddress)
        
        self.emailTF.placeholder = getLocalizedString(key: .enterEmailAddress)

        self.passwordTF.placeholder = getLocalizedString(key: .enterPassword)

        self.passwordLbl.text = getLocalizedString(key: .password)
        
        self.loginBtn.setUpButton(title: getLocalizedString(key: .logIn).uppercased(), textColor: sColorWhite, borderColor: sColorClear, fontSize: AppFont.size22.bold, bgColor: sColorOrange, cornerRadius: 5.0, borderWidth: 0.0)
        
        self.signUpLbl.setupLabel(title: getLocalizedString(key: .dontHaveAnAccount), fontSize: AppFont.size16.regular, textColor: sColorWhite)
        
        self.signUpBtn.setUpButton(title: getLocalizedString(key: .signUp).uppercased(), textColor: sColorYellow, borderColor: sColorClear, fontSize: AppFont.size16.bold, bgColor: sColorClear, cornerRadius: 0.0, borderWidth: 0.0)
    }
}

//MARK:- EXTENSION : UITextField Delegate Methods
extension LoginVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

struct LanguageDict {
    var languageName : String
    var languageCode : String
}

var LanguageArray : Array<LanguageDict> =  [
    LanguageDict(languageName: "English", languageCode: "en"),
    LanguageDict(languageName: "Ukrainian", languageCode: "uk")
]
