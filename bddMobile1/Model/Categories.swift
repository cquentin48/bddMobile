//
//  CheckListItem.swift
//  bddMobile1
//
//  Created by lpiem on 22/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class Categories{
    var title:String?
    var isChecked:Bool=false
    var image:String?
    var description:String?
    var itemList: [String]?
    
    public init(title:String, isChecked:Bool=false, image:String=""){
        self.title = title
        self.isChecked = isChecked
        self.image = image
    }
}
