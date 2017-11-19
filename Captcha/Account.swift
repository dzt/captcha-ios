//
//  Account.swift
//  Captcha
//
//  Created by Peter Soboyejo on 10/7/17.
//  Copyright © 2017 Peter Soboyejo. All rights reserved.
//

import RealmSwift

open class Account: Object {
    @objc open dynamic var userkey = ""
    @objc open dynamic var sitekey = ""
    @objc open dynamic var domain = ""
}

