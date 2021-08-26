//
//  NotesListTVCell.swift
//  DailyNotes
//
//  Created by Tecocraft on 23/08/21.
//

import UIKit

class NotesListTVCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var notesImageView: UIImageView!
    
    @IBOutlet weak var notesTitleLbl: UILabel!
    
    @IBOutlet weak var dateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }

    func setupView() {
        
        self.mainView.layer.cornerRadius = 5.0
        
        self.mainView.backgroundColor = sColorLightGray.withAlphaComponent(0.7)
    }
}
