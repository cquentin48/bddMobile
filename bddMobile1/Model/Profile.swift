//
//  Profile.swift
//  bddMobile1
//
//  Created by lpiem on 18/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit
let profile = Profile()
class Profile{
    var username:String
    var password:String
    var email:String
    
    required init(email:String = "", password:String="", username:String="") {
        self.email=email
        self.password=password
        self.username=username
    }
}
