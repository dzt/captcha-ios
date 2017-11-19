//
//  AcknowledgmentsTableViewController.swift
//  Captcha
//
//  Created by Peter Soboyejo on 11/18/17.
//  Copyright © 2017 Peter Soboyejo. All rights reserved.
//

import Foundation
import UIKit
import SafariServices
import MessageUI

class AcknowledgmentsTableViewController : UITableViewController, MFMailComposeViewControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func openURL(_ string: String) {
        if let url = URL(string: string) {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 && indexPath.row == 0 {
            openURL("https://github.com/SwiftyJSON/SwiftyJSON")
        } else if indexPath.section == 0 && indexPath.row == 1 {
            openURL("https://github.com/SVProgressHUD/SVProgressHUD")
        } else {
            openURL("https://github.com/realm/realm-cocoa")
        }
    }
    
}
