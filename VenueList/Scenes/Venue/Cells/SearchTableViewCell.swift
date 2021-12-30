//
//  SearchTableViewCell.swift
//  VenueList
//
//  Created by Erva Hatun Tekeoğlu on 30.12.2021.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    var onDoneButton: (() -> Void)?
    func setupTextFields() {
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done,
                                        target: self, action: #selector(doneButtonTapped))
        let toolbar = UIToolbar()
        toolbar.setItems([flexSpace, doneButton], animated: true)
        toolbar.sizeToFit()
        textField.inputAccessoryView = toolbar
    }
        
    @objc func doneButtonTapped() {
        onDoneButton?()
    }

}
