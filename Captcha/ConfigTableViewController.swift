//
//  ConfigTableViewController.swift
//  Captcha
//
//  Created by Peter Soboyejo on 10/7/17.
//  Copyright © 2017 Peter Soboyejo. All rights reserved.
//

import UIKit

class ConfigTableViewController: UITableViewController {
    
    @IBOutlet weak var fetchSwitch: UISwitch!
    @IBOutlet weak var sitekeyField: UITextField!
    @IBOutlet weak var domainField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}
