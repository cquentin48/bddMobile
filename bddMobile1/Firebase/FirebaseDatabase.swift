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
        let ref = db.child("collection").ref
        category.id = (ref.childByAutoId()).key!
        let categoryRef = ref.child(category.id).setValue([
            "title" : category.title,
            "description" : category.description,
            "image" : category.image,
            "authorId" : category.authorId,
            "isChecked" : category.isChecked,
            "itemList" : category.itemList
        ])
    }
    
    func loadAllCategories(){
        let ref = db.child("collection").ref
        ref.observe(.value, with: {(snapshot) in
            let categories = snapshot.value as? NSDictionary
            let categoriesKey = categories?.allKeys as! Array<String>
            categoriesKey.map{(singleKey) in
                self.addCategoryToList(rawData: categories?.object(forKey: singleKey) as! NSDictionary, index: singleKey)
            }
        }) {(error) in
            print("Error : ", error)
        }
    }
    
    func addCategoryToList(rawData:NSDictionary, index:String)->Categories{
        let category = Categories(title: rawData.object(forKey: "title") as! String,
                                  isChecked: rawData.object(forKey: "isChecked") as! Bool,
                                  image: rawData.object(forKey: "image") as! String,
                                  description: rawData.object(forKey: "description") as! String,
                                  itemList: (rawData.object(forKey: "itemList") != nil) as! [String],
                                  id: index)
        return category
    }
}
