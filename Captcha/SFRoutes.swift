//
//  SFRoutes.swift
//  Captcha
//
//  Created by Peter Soboyejo on 10/7/17.
//  Copyright © 2017 Peter Soboyejo. All rights reserved.
//

import Foundation
import SwiftyJSON

class SFRoutes {
    
    func sendCaptchaToken(user_token: String, captchaToken: String, completion: ((_ response: ServerResponse?, _ error: String?) -> Void)?) {
        
        var params = [String: String]()
        let body = [
            "user_token": user_token,
            "captchaToken": captchaToken
            ] as [String: Any]
        
        Request.request("/api/submitToken", requestType: "POST", body: body) { json, error in
            guard let courses = json?["courses"].array else {
                completion?(nil, error)
                return
            }
            completion?(ServerResponse(json: json!), error)
        }
    }
    
}
