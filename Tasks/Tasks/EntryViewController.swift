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
        field.delegate = self
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        
        return true
    }
    @IBAction func saveTask() {
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title = "New Task"
        navigationController?.pushViewController(vc, animated: true)
    }

}
