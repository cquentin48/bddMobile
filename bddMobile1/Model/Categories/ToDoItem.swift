//
//  ToDoItem.swift
//  bddMobile1
//
//  Created by lpiem on 09/04/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class ToDoItem{
    var toDoName:String
    var toDoDescription:String
    var toDoRemindDate:Date
    
    var toDoCreationDate:Date
    var toDoLastModificationDate:Date
    
    var toDoImageIcon:String
    var toDoKey:String
    
    init(toDoName:String = "", toDoDescription:String = "", toDoRemindDate:Date = Date(), toDoCreationDate:Date = Date(), toDoLastModificationDate:Date = Date(), toDoImageIcon:String = "", toDoKey:String = "") {
        self.toDoName = toDoName
        self.toDoDescription = toDoDescription
        self.toDoRemindDate = toDoRemindDate
        
        self.toDoCreationDate = toDoCreationDate
        self.toDoLastModificationDate = toDoLastModificationDate
        
        self.toDoImageIcon = toDoImageIcon
        self.toDoKey = toDoKey
    }
    
    func generateKey()->String{
        return firebaseCloudFirestore.generateKey(ref: firebaseCloudFirestore.toDoRef)
    }
    
    func generateStringFromDate(rawDate:Date)->String{
        let dateTimeFormatter = DateFormatter()
        dateTimeFormatter.calendar = Calendar(identifier: .iso8601)
        dateTimeFormatter.dateFormat = "dd/MM/yyyy hh:mm:ss"
        return dateTimeFormatter.string(from: rawDate)
    }
}
