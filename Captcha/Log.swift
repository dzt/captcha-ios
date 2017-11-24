//
//  Log.swift
//  Captcha
//
//  Created by Peter Soboyejo on 11/24/17.
//  Copyright © 2017 Peter Soboyejo. All rights reserved.
//

import RealmSwift

open class Log: Object {
    @objc open dynamic var timestamp = ""
    @objc open dynamic var token = ""
    @objc open dynamic var sitekey = ""
    @objc open dynamic var domain = ""
}
