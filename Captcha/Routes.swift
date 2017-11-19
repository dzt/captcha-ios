//
//  SFRoutes.swift
//  Captcha
//
//  Created by Peter Soboyejo on 10/7/17.
//  Copyright © 2017 Peter Soboyejo. All rights reserved.
//

import Foundation
import SwiftyJSON

class Routes {
    
    func sendCaptchaToken(captchaToken: String, completion: ((_ response: ServerResponse?, _ error: String?) -> Void)?) {
        
        let params = [String: String]()
        let body = [
            "g-recaptcha-response":captchaToken
            ] as [String: Any]
        
        Request.request("/submit", requestType: "POST", params: params, body: body) { json, error in

            completion?(ServerResponse(json: json!), error)
        }
    }
    
}
