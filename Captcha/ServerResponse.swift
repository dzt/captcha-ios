//
//  ServerResponse.swift
//  Captcha
//
//  Created by Peter Soboyejo on 10/7/17.
//  Copyright © 2017 Peter Soboyejo. All rights reserved.
//

import SwiftyJSON

class ServerResponse {
    
    var message: String?
    var error: Bool?
    
    init(json: JSON) {
        message = json["message"].string
        error = json["error"].bool
    }
    
}

