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
    var elementLoaded:Bool = false
    private var collectionRef:DatabaseReference
    
    func saveCategories(){
        modelData.categories!.enumerated().map{ (index, singleCategory) in
            addCategories(category: singleCategory, position: index)
        }
    }
    
    required init() {
        collectionRef = db.child("collection").ref
    }
    
    func addCategories(category:Categories, position:Int){
        category.id = (collectionRef.childByAutoId()).key!
        let categoryRef = collectionRef.child(category.id).setValue([
            "title" : category.title,
            "description" : category.description,
            "image" : category.image,
            "authorId" : category.authorId,
            "isChecked" : category.isChecked,
            "itemList" : category.itemList
        ])
    }
    
    func removeCategories(key:String){
        let elementRef = collectionRef.child(key)
        elementRef.removeValue{ error, _ in
            if(error != nil){
                print("Catégorie supprimée")
            }else{
                print("Error"+error.debugDescription)
            }
        }
    }
    
    func loadAllCategories(){
        collectionRef.observe(.value, with: {(snapshot) in
            let categories = snapshot.value as? NSDictionary
            let categoriesKey = categories?.allKeys as! Array<String>
            categoriesKey.map{(singleKey) in
               modelData.categories?.append(self.addCategoryToList(rawData: categories?.object(forKey: singleKey) as! NSDictionary, index: singleKey))
                if(modelData.categories?.count == categories?.count){
                    self.elementLoaded = true
                }
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
                                  id: index,
                                  authorId: rawData.object(forKey: "authorId") as! String)
        return category
    }
}
