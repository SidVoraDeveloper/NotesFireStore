//
//  AddNotesVC.swift
//  DailyNotes
//
//  Created by Tecocraft on 23/08/21.
//

import UIKit
import Firebase

class AddNotesVC: UIViewController {
    
    //MARK:- IB_OUTLETS
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var navigationBar: NavigationBar!
    
    @IBOutlet weak var notesImageView: UIImageView!
    
    @IBOutlet weak var addImageLbl: UILabel!
    
    @IBOutlet weak var editImageBtn: UIButton!
    
    @IBOutlet weak var titleLbl: ThemeTitleLabel!
    
    @IBOutlet weak var descLbl: ThemeTitleLabel!
    
    @IBOutlet weak var descTV: UITextView!
    
    @IBOutlet weak var descTVCountLbl: UILabel!
    
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var descTVHeightConstraint: NSLayoutConstraint!
    
    //MARK:- DECLARATION
    private let imagePicker = UIImagePickerController()
    
    private let storage = Storage.storage()
    
    var snapShotDetail: QueryDocumentSnapshot?
    
    var isAddNotes = false
    
    
    //MARK:- VIEW_METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        
        self.scrollView.layer.backgroundColor = sColorDarkGray.cgColor
        
        self.contentView.layer.backgroundColor = sColorDarkGray.cgColor
        
        self.view.backgroundColor = sColorDarkGray
        
        self.navigationBar.title = getLocalizedString(key: .addNotes)
        
        imagePicker.delegate = self
        
        descTV.layer.borderColor = sColorOrange.cgColor
        descTV.layer.borderWidth = 2.0
        descTV.layer.cornerRadius = 5.0
        descTV.layer.backgroundColor = sColorDarkGray.cgColor
        descTV.textColor = sColorWhite
        
        descTV.delegate = self
        
        descTVCountLbl.textColor = sColorYellow
        
        descTVCountLbl.font = AppFont.size17.regular
        
        descLbl.text = getLocalizedString(key: .description)
        
        addImageLbl.setupLabel(title: getLocalizedString(key: .addImage), fontSize: AppFont.size22.bold, textColor: sColorWhite.withAlphaComponent(0.5))
        
        notesImageView.layer.cornerRadius = 5.0
        
        notesImageView.layer.borderWidth = 2.0
        
        notesImageView.layer.borderColor = sColorOrange.cgColor
        
        editImageBtn.setupRoundedButton(borderWidth: 0.0, borderColor: sColorClear, cornerRadius: 0.0, bgColor: sColorOrange)
            
        saveBtn.setUpButton(title: getLocalizedString(key: .addItem).uppercased(), textColor: sColorWhite, borderColor: sColorClear, fontSize: AppFont.size22.bold, bgColor: sColorOrange, cornerRadius: 5.0, borderWidth: 0.0)
        
        // Dismiss Keyboard when outside of Textfield Click
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        setUIAddOrDisplayNote()
        
        saveBtn.addTarget(self, action: #selector(saveBtnClicked(sender:)), for: .touchUpInside)
        
        editImageBtn.addTarget(self, action: #selector(addNotesPictureBtnPressed(sender:)), for: .touchUpInside)
        
        navigationBar.btnBack.addTarget(self, action: #selector(backBtnClicked(sender:)), for: .touchUpInside)
        
        navigationBar.btnRight.addTarget(self, action: #selector(logoutBtnClicked(sender:)), for: .touchUpInside)
    }
    
    
    //MARK:- IB_ACTION
    @objc private func saveBtnClicked(sender: UIButton) {
        
        if checkTextFieldValidations() {
            
            sLoaderView.startAnimating()
            
            let date = Date()
            
            let sDate = date.toString(format: "ddMMYYss")
            
            let myref = storage.reference().child("images/image_\(sDate).png")
            
            myref.putData(notesImageView.image!.pngData()!, metadata: nil) { (metadata, error) in
                
                myref.downloadURL { (url, error) in
                    
                    fbNoteRef.addDocument(data: [dbField.kdbTitle: self.descTV.text ?? "",
                                                 dbField.kdbImage: url?.absoluteString ?? "",
                                                 dbField.kdbTimestamp: FieldValue.serverTimestamp()]) { err in
                        
                        sLoaderView.stopAnimating()
                        
                        if let err = err {
                            print("Error adding document: \(err)")
                            
                        } else {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
        }
    }
    
    @IBAction private func addNotesPictureBtnPressed(sender: UIButton) {
        
        imagePicker.allowsEditing = false
        
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc private func logoutBtnClicked(sender: UIButton) {
        showCustomAlert(title: "", message: getLocalizedString(key: .AreYouSureLogout))
    }
    
    @objc private func backBtnClicked(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        descTV.resignFirstResponder()
    }
    
    
    //MARK:- OTHER_METHODS
    private func setUIAddOrDisplayNote()
    {
        if isAddNotes {
            
            editImageBtn.isHidden = false
            
            descTV.isUserInteractionEnabled = true
            
            saveBtn.isHidden = false
            
            descTVCountLbl.isHidden = false
            
            descTVHeightConstraint.constant = 200
            
            descTV.isScrollEnabled = true
            
            descTV.isUserInteractionEnabled = true
            
        } else {
            
            editImageBtn.isHidden = true
            
            notesImageView.sd_setImage(with: URL(string: snapShotDetail?["image"] as? String ?? ""), placeholderImage: UIImage(named:""))
                   
            descTV.text = snapShotDetail?["title"] as? String ?? ""
            
            descTV.isUserInteractionEnabled = false
            
            saveBtn.isHidden = true
            
            descTVCountLbl.isHidden = true
            
            descTVHeightConstraint.constant = 400
            
            descTV.isScrollEnabled = true
            
            descTV.isUserInteractionEnabled = false
        }
    }
    
    private func showCustomAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: getLocalizedString(key: .yes), style: UIAlertAction.Style.default, handler: { (alertaction) in
            self.performSegue(withIdentifier: "showLoginVC", sender: self)
        }))
        
        alert.addAction(UIAlertAction(title: getLocalizedString(key: .cancel), style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func checkTextFieldValidations() -> Bool {
        
        if notesImageView.image == nil {
            showValidationAlert(title: "", message: getLocalizedString(key: .pleaseAddImage))
            return false
        }
        
        if Validations().isFieldEmpty(descTV.text ?? "")
        {
            showValidationAlert(title: "", message: getLocalizedString(key: .pleaseAddDescription))
            return false
        }
        
        return true
    }
}

//MARK:- EXTENSION - UIImagePicker Delegate Methods
extension AddNotesVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            notesImageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion:nil)
    }
}

//MARK:- EXTENSION : UITextView Delegate Methods
extension AddNotesVC: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        
        let numberOfChars = newText.count
        
        var isLimitReached = false
        
        if numberOfChars <= noteCharLimit // 500 Limit Value
        {
            isLimitReached = true
            descTVCountLbl.text = "\(numberOfChars)/\(String(noteCharLimit))"
        }
        else
        {
            isLimitReached = false
        }
        
        return isLimitReached
    }
}
