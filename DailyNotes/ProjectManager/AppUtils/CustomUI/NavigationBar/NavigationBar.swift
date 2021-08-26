//
//  NavigationBar.swift
//  FluentFast
//
//  Created by Tecocraft on 06/01/21.
//

import UIKit

//@IBDesignable
class NavigationBar: UIView {
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnRight: UIButton!
    
    var view : UIView!
    
    @IBInspectable var title: String? {
        get {
            return lblTitle.text
        }
        set(title) {
            lblTitle.text = title
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        setup()
    }
    
    
    override func prepareForInterfaceBuilder() {
        setup()
    }
    
    func setup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(view)
        sharedInit()
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for:type(of: self))
        let nib = UINib(nibName: "NavigationBar", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
        
    }
    
    
    func sharedInit(){
        
        self.viewBg.backgroundColor = sColorDarkGray
        
        self.btnBack.setImage(UIImage(named: "ic_back"), for: .normal)
        
        self.lblTitle.font = AppFont.size22.bold
        self.lblTitle.textColor = sColorYellow
        self.lblTitle.text = title
        
        self.btnRight.setImage(UIImage(named: "logout"), for: .normal)
        
        self.clipsToBounds = true
    }
    
    

}
