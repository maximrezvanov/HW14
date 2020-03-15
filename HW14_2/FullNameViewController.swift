//
//  FullNameViewController.swift
//  HW14_2
//
//  Created by MaximRezvanov on 3/13/20.
//  Copyright © 2020 MaximRezvanov. All rights reserved.
//

import UIKit
import Foundation

class FullNameViewController: UIViewController {
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var secondNameTextField: UITextField!
    
    @IBAction func firstNameEntered(_ sender: UITextField) {
        Persistance.shared.firstName = firstNameTextField.text
    }
    
    @IBAction func secondNameEntered(_ sender: UITextField) {
        Persistance.shared.secondName = secondNameTextField.text
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        firstNameValue()
        secondNameValue()
    }
    
    
    func firstNameValue(){
        if let value = Persistance.shared.firstName{
            firstNameTextField.text = value
        }
    }
    
    func secondNameValue(){
        let value2 = Persistance.shared.secondName
        if value2 != nil{
            secondNameTextField.text = value2
        }
    }
}




