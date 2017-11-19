//
//  HistoryTableViewController.swift
//  Captcha
//
//  Created by Peter Soboyejo on 10/8/17.
//  Copyright © 2017 Peter Soboyejo. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    
    private var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel = UILabel()
        errorLabel.alpha = 1
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        errorLabel.textColor = UIColor.black
        errorLabel.text = "No log history found."
        view.addSubview(errorLabel)
        self.tableView.reloadData()
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let errorLabelFrame = errorLabel.textRect(forBounds: CGRect(x: 0, y: 0, width: view.frame.size.width - 64, height: CGFloat.greatestFiniteMagnitude), limitedToNumberOfLines: 10)
        errorLabel.frame = CGRect(x: (view.frame.size.width - errorLabelFrame.size.width) / 2, y: (view.frame.size.height - errorLabelFrame.size.height) / 10, width: errorLabelFrame.size.width, height: errorLabelFrame.size.height)
    }
    
    

}
