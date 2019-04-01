//
//  Database.swift
//  bddMobile1
//
//  Created by lpiem on 01/04/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit
import Firebase
let firebaseCloudFirestore = FirebaseDatabase()
class FirebaseDatabase{
    var db: DatabaseReference! = Database.database().reference()
    
    func saveCategories(){
        modelData.categories!.enumerated().map{ (index, singleCategory) in
            addCategories(category: singleCategory, position: index)
        }
    }
    
    func addCategories(category:Categories, position:Int){
        let ref = db.child("users").child(Auth.auth().currentUser!.uid).ref
        let id = String(position)
        ref.child("collection").child(id).setValue([
            "title" : category.title,
            "checked" : category.isChecked,
            "image" : category.image,
            "description" : category.description,
            "itemList" : category.itemList
            ])
    }
}
