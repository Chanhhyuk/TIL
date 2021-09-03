//
//  EntryViewController.swift
//  Tasks
//
//  Created by ChanHyuk Kim on 2021/09/03.
//

import UIKit

class EntryViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var field: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }

}
