//
//  NotesListVC.swift
//  DailyNotes
//
//  Created by Tecocraft on 23/08/21.
//

import UIKit
import Firebase
import SDWebImage

class NotesListVC: UIViewController {

    //MARK:- IB_OUTLETS
    @IBOutlet weak var navigationBar: NavigationBar!
    
    @IBOutlet weak var notesListTblVw: UITableView!
    
    @IBOutlet weak var addNotesBtn: UIButton!
    
    
    //MARK:- DECLARATION
    
    private var snapShotArray = [QueryDocumentSnapshot]()
        
    private var snapShotDetail: QueryDocumentSnapshot?
    
    private let storage = Storage.storage()
    
    private var isAddNotes = false
    
    
    //MARK:- VIEW_METHODS
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
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
        
        self.notesListTblVw.backgroundColor = sColorDarkGray
        
        self.view.backgroundColor = sColorDarkGray
        
        self.navigationBar.title = getLocalizedString(key: .notesList)
            
        addNotesBtn.setupRoundedButton(borderWidth: 0.0, borderColor: sColorClear, cornerRadius: 0.0, bgColor: sColorOrange)
        
        sLoaderView.startAnimating()
        
        // Read all collection data from Firestore
        
        fbNoteRef.order(by: dbField.kdbTimestamp, descending: true)
            .getDocuments { (snapshot, error) in
            
            sLoaderView.stopAnimating()
            
            if snapshot?.documents != nil {
                self.snapShotArray = snapshot!.documents
            }
            
            self.notesListTblVw.reloadData()
        }
        
        self.navigationBar.btnBack.isHidden = true
        
        addNotesBtn.addTarget(self, action: #selector(addNotesBtnClicked(sender:)), for: .touchUpInside)
        
        navigationBar.btnRight.addTarget(self, action: #selector(logoutBtnClicked(sender:)), for: .touchUpInside)
    }
    
    private func setupTable() {
        notesListTblVw.register(UINib(nibName: "NotesListTVCell", bundle: nil), forCellReuseIdentifier: "NotesListTVCell")
        notesListTblVw.delegate = self
        notesListTblVw.dataSource = self
    }
    
    
    //MARK:- IB_ACTION
    @objc private func addNotesBtnClicked(sender: UIButton) {
        self.isAddNotes = true
        self.performSegue(withIdentifier: "showAddNotesVC", sender: self)
    }
    
    @objc private func logoutBtnClicked(sender: UIButton) {
        
        showCustomAlert(title: "", message: getLocalizedString(key: .AreYouSureLogout))
    }
    
    
    //MARK:- OTHER_METHODS
    private func showCustomAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: getLocalizedString(key: .yes), style: UIAlertAction.Style.default, handler: { (alertaction) in
            self.performSegue(withIdentifier: "showLoginVC", sender: self)
        }))
        
        alert.addAction(UIAlertAction(title: getLocalizedString(key: .cancel), style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- SEGUE_METHODS
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showAddNotesVC" {
            
            if let destinationVC = segue.destination as? AddNotesVC {
                
                if isAddNotes == false {
                    destinationVC.snapShotDetail = snapShotDetail
                    destinationVC.isAddNotes = isAddNotes // AddNotes Screen should display Image which is stored in Firestore
                    
                } else {
                    destinationVC.isAddNotes = isAddNotes // This is New Notes
                }
            }
        }
    }

}

//MARK:- EXTENSION: Tableview Delegate & Datasource Methods
extension NotesListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snapShotArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesListTVCell", for: indexPath) as! NotesListTVCell
    
        cell.notesImageView.sd_imageIndicator = SDWebImageActivityIndicator.white
        cell.notesImageView.sd_setImage(with: URL(string: snapShotArray[indexPath.row][dbField.kdbImage] as? String ?? "")) { img, err, SDImageCacheType, url in
            
        }
        cell.notesImageView.setupRoundedImage(borderWidth: 0.0, borderColor: sColorWhite, cornerRadius: 0.0)
        
        cell.notesTitleLbl.setupLabel(title: snapShotArray[indexPath.row][dbField.kdbTitle] as? String ?? "", fontSize: AppFont.size18.regular, textColor: sColorWhite)
        
        let ts = snapShotArray[indexPath.row][dbField.kdbTimestamp] as? Timestamp
        
        let date = ts?.dateValue() ?? Date()
        
        let sDate =  date.toString(format: "dd MMMM YYYY HH:mm")
        
        cell.dateLbl.setupLabel(title: sDate, fontSize: AppFont.size14.semibold, textColor: sColorYellow)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.snapShotDetail = snapShotArray[indexPath.row]
        
        self.isAddNotes = false
        
        self.performSegue(withIdentifier: "showAddNotesVC", sender: self)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            let alert = UIAlertController(title: "", message: getLocalizedString(key: .areYouSureDelete), preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: getLocalizedString(key: .yes), style: .default, handler: { action in
                
                sLoaderView.startAnimating()
                
                let documentID = self.snapShotArray[indexPath.row].documentID
                
                fbNoteRef.document(documentID).delete() {err in
                        
                        if let err = err {
                            print("Error removing document: \(err)")
                            
                        } else {
                            print("Document successfully removed!")
                            
                            self.snapShotArray.remove(at: indexPath.row)
                            
                            sLoaderView.stopAnimating()
                            self.notesListTblVw.reloadData()
                        }
                    }
            }))
            
            alert.addAction(UIAlertAction(title: getLocalizedString(key: .no), style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
}
