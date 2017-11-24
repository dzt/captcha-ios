//
//  HistoryTableViewController.swift
//  Captcha
//
//  Created by Peter Soboyejo on 10/8/17.
//  Copyright © 2017 Peter Soboyejo. All rights reserved.
//

import UIKit
import RealmSwift

class HistoryTableViewController: UITableViewController {
    
    private var errorLabel: UILabel!
    let realm = try! Realm()
    let items = try! Realm().objects(Log.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.refreshControl?.addTarget(self, action: #selector(handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)
        
        errorLabel = UILabel()
        
        print(realm.objects(Log.self).count)
        
        if realm.objects(Log.self).count == 0 {
            errorLabel.numberOfLines = 0
            errorLabel.textAlignment = .center
            errorLabel.textColor = UIColor.black
            errorLabel.text = "No log history found."
            errorLabel.alpha = 1
        }
        
        view.addSubview(errorLabel)
        
        self.tableView.reloadData()
        
    
    }
    
    @objc func handleRefresh(refreshControl: UIRefreshControl) {
        print("hi")
        self.tableView.reloadData()
        if realm.objects(Log.self).count > 0 {
            errorLabel.alpha = 0
        }
        self.refreshControl?.endRefreshing()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "logCell", for: indexPath)
        let info = items[indexPath.row]
        cell.textLabel?.text = info.domain
        cell.detailTextLabel?.text = info.timestamp
        return cell
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let errorLabelFrame = errorLabel.textRect(forBounds: CGRect(x: 0, y: 0, width: view.frame.size.width - 64, height: CGFloat.greatestFiniteMagnitude), limitedToNumberOfLines: 10)
        errorLabel.frame = CGRect(x: (view.frame.size.width - errorLabelFrame.size.width) / 2, y: (view.frame.size.height - errorLabelFrame.size.height) / 10, width: errorLabelFrame.size.width, height: errorLabelFrame.size.height)
    }
    
    

}
