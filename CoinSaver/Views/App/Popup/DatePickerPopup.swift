//
//  DatePickerPopup.swift
//  CoinSaver
//
//  Created by fiskirton on 12.12.2020.
//

import UIKit
import MonthYearPicker

class DatePickerPopup: Popup {

    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var datePicker: MonthYearPickerView!
    
    @IBAction func saveDate(_ sender: UIButton) {
        NotificationCenter.default.post(name: .saveDate, object: self)
        
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
