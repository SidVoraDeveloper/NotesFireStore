//
//  AppConstants.swift
//  DailyNotes
//
//  Created by Tecocraft on 23/08/21.
//

import Foundation
import UIKit
import NVActivityIndicatorView
import Firebase

let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height

let iPhone4_i5 = UIScreen.main.bounds.size.width == 320
let iPhone8_iX_iXs_i11pro = UIScreen.main.bounds.size.width == 375
let iPhone8pluse_iXR_i11_iMax = UIScreen.main.bounds.size.width == 414
let iPhone12ProMax = UIScreen.main.bounds.size.width == 428

//#MAERK: APP LOADER
let sLoderType = NVActivityIndicatorType.lineScale
let sLoaderSize = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
let sShowLoaderValue = 3
let sLoaderColor = sColorOrange
let sLoaderTitle = "Loading"
let sLoaderTitleColor = UIColor.white

let sLoaderView = NVActivityIndicatorView(frame: sLoaderSize, type: sLoderType, color: sLoaderColor, padding: SCREEN_WIDTH/1.8)

//#MARK:- Key Window
var sKeyWindow: UIWindow? {
    if #available(iOS 13, *) {
        return UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    } else {
        return UIApplication.shared.keyWindow
    }
}

let db = Firestore.firestore()

let fbNoteRef = db.collection(dbField.kdbUsers)
    .document(Auth.auth().currentUser?.uid ?? "")
    .collection(dbField.kdbNotes)

let noteCharLimit = 500 // 500 Limit Value
