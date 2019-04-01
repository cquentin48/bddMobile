//
//  CheckListItem.swift
//  bddMobile1
//
//  Created by lpiem on 22/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class Categories : Codable{
    var title:String?
    var isChecked:Bool=false
    var image:String?
    var description:String?
    var itemList: [String]?
    var id:String
    
    public init(title:String, isChecked:Bool=false, image:String="", description:String="", itemList:[String]=[String](), id:String=""){
        self.title = title
        self.isChecked = isChecked
        self.image = image
        self.description = description
        self.itemList = itemList
        self.id = id
    }
    
    func toogleCheck(){
        isChecked = !isChecked
    }
}
