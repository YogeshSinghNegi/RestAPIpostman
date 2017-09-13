//
//  SignUpDataVC.swift
//  RestAPIpostman
//
//  Created by appinventiv on 09/09/17.
//  Copyright © 2017 yogesh singh negi. All rights reserved.
//

import UIKit

class SignUpDataVC: UIViewController {
    
    var form = [String:Any]()
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var fieldLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    
        self.nameLabel.text = form["username"] as? String
        self.fieldLabel.text = form["field"] as? String
        
    }
    
    @IBAction func goBackBtnTapped(_ sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
}

