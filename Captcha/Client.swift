//
//  Client.swift
//  Captcha
//
//  Created by Peter Soboyejo on 10/7/17.
//  Copyright © 2017 Peter Soboyejo. All rights reserved.
//

class Client {
    public class var shared: Client {
        struct Static {
            static let instance = Client()
        }
        return Static.instance
    }
    
    public let cr: Routes
    
    private init() {
        cr = Routes()
    }
}

