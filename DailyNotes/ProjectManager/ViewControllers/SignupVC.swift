//
//  SignupVC.swift
//  DailyNotes
//
//  Created by Tecocraft on 23/08/21.
//

import UIKit
import FirebaseAuth

class SignupVC: UIViewController {
    
    //MARK:- IB_OUTLETS
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var chooseLanguageBtn: UIButton!
    @IBOutlet weak var headerLbl: UILabel!
    
    @IBOutlet weak var fullNameLbl: ThemeTitleLabel!
    @IBOutlet weak var fullNameView: ThemeView!
    @IBOutlet weak var fullNameTF: UITextField!
    
    @IBOutlet weak var emailAddressLbl: ThemeTitleLabel!
    @IBOutlet weak var emailView: ThemeView!
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordLbl: ThemeTitleLabel!
    @IBOutlet weak var passwordView: ThemeView!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var confirmPasswordLbl: ThemeTitleLabel!
    @IBOutlet weak var confirmPasswordView: ThemeView!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    
    @IBOutlet weak var signupBtn: UIButton!
    
    @IBOutlet weak var loginLbl: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var chooseLanguageTF: UITextField!
    
    
    //MARK:- DECLARATION
   // private var languageArray = ["UA", "EN"]
        
    
    //MARK:- VIEW_METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
  
        setupView()
//        setTranslatedText()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setTranslatedText()
    }
    
    func setupView() {
        
        self.navigationController?.navigationBar.isHidden = true
        
        scrollView.backgroundColor = sColorDarkGray
        self.view.backgroundColor = sColorDarkGray
        contentView.backgroundColor = sColorDarkGray
        
        self.chooseLanguageBtn.titleLabel?.lineBreakMode = .byCharWrapping
        
        self.chooseLanguageBtn.layer.backgroundColor = sColorOrange.cgColor
        
        self.chooseLanguageBtn.titleLabel?.textAlignment = .center
        
        self.chooseLanguageBtn.layer.cornerRadius = 5.0
        
        self.passwordTF.isSecureTextEntry = true
        
        self.passwordTF.enablePasswordToggle()
        
        self.confirmPasswordTF.isSecureTextEntry = true
        
        self.confirmPasswordTF.enablePasswordToggle()
        
        // Dismiss Keyboard when outside of Textfield Click
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        chooseLanguageBtn.addTarget(self, action: #selector(chooseLanguageBtnClick(sender:)), for: .touchUpInside)
        
        signupBtn.addTarget(self, action: #selector(signUpBtnClicked(sender:)), for: .touchUpInside)
        
        loginBtn.addTarget(self, action: #selector(loginBtnClicked(sender:)), for: .touchUpInside)
    }
    
    
    //MARK:- IB_ACTION
    @objc func signUpBtnClicked(sender: UIButton) {
        if checkTextFieldValidations() {
            
            self.view.endEditing(true)
            
            sLoaderView.startAnimating()
            
            Auth.auth().createUser(withEmail: emailTF.text ?? "", password: passwordTF.text ?? "") { (result, error) in
                
                sLoaderView.stopAnimating()
                
                if result != nil {
                    self.performSegue(withIdentifier: "showNotesListVC", sender: self)
                    
                } else {
                    showValidationAlert(title: "", message: error?.localizedDescription ?? "")
                }
            }
        }
    }
    
    @objc func loginBtnClicked(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @objc func chooseLanguageBtnClick(sender: UIButton) {
        
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
    func checkTextFieldValidations() -> Bool {
        
        if Validations().isFieldEmpty(fullNameTF.text ?? "")  {
            showValidationAlert(title: "", message: getLocalizedString(key: .fullNameMandatory))
            return false
        }
        
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
        else
        {
            if Validations().isValidatePassword(sPassword: passwordTF.text ?? "") == false {
                showValidationAlert(title: "", message: getLocalizedString(key: .validpassword))
                return false
            }
        }
        
        if Validations().isFieldEmpty(confirmPasswordTF.text ?? "")
        {
            showValidationAlert(title: "", message: getLocalizedString(key: .confirmPasswordMandatory))
            return false
        }
        else
        {
            if confirmPasswordTF.text !=  passwordTF.text {
                showValidationAlert(title: "", message: getLocalizedString(key: .confirmPasswordMatch))
                return false
            }
        }
        
        return true
    }
    
    func setTranslatedText() {
        
        let language = getSelLanguage()
        let myNormalAttributedTitle = NSAttributedString(string: language.languageName, attributes: [
                                                                            NSAttributedString.Key.font : AppFont.size15.semibold,
                                                                            NSAttributedString.Key.foregroundColor : sColorWhite])
        
        self.chooseLanguageBtn.setAttributedTitle(myNormalAttributedTitle, for: .normal)
        
        self.fullNameLbl.text = getLocalizedString(key: .fullName)
        
        self.emailAddressLbl.text = getLocalizedString(key: .emailAddress)
        
        self.passwordLbl.text = getLocalizedString(key: .password)
        
        self.confirmPasswordLbl.text = getLocalizedString(key: .confirmPassword)
        
        self.fullNameTF.placeholder = getLocalizedString(key: .enterFullName)
        
        self.emailTF.placeholder = getLocalizedString(key: .enterEmailAddress)

        self.passwordTF.placeholder = getLocalizedString(key: .enterPassword)
        
        self.confirmPasswordTF.placeholder = getLocalizedString(key: .enterConfirmPassword)
        
        self.headerLbl.setupLabel(title: getLocalizedString(key: .signUp).uppercased(), fontSize: AppFont.size30.bold, textColor: sColorYellow)
        
        self.signupBtn.setUpButton(title: getLocalizedString(key: .signUp).uppercased(), textColor: sColorWhite, borderColor: sColorClear, fontSize: AppFont.size22.bold, bgColor: sColorOrange, cornerRadius: 5.0, borderWidth: 0.0)
        
        self.loginLbl.setupLabel(title: getLocalizedString(key: .alreadyHaveAnAccount), fontSize: AppFont.size16.regular, textColor: sColorWhite)
        
        self.loginBtn.setUpButton(title: getLocalizedString(key: .logIn).uppercased(), textColor: sColorYellow, borderColor: sColorClear, fontSize: AppFont.size16.bold, bgColor: sColorClear, cornerRadius: 0.0, borderWidth: 0.0)
    }

}

//MARK:- EXTENSION : UITextField Delegate Methods
extension SignupVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
