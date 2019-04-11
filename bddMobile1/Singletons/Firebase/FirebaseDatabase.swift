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
    var categoriesLoaded:Bool = false
    var toDoItemLoaded:Bool = false
    var collectionRef:DatabaseReference
    var toDoRef:DatabaseReference
    
    func saveCategories(){
        modelData.categories!.enumerated().map{ (index, singleCategory) in
            addCategories(category: singleCategory)
        }
    }
    
    required init() {
        collectionRef = db.child("collection")
        toDoRef = db.child("toDoItems")
    }
    
    func addCategories(category:Categories){
        category.id = generateKey(ref: collectionRef)
        let categoryRef = collectionRef.child(category.id).setValue([
            "title" : category.title,
            "description" : category.description,
            "image" : category.image,
            "authorId" : category.authorId,
            "isChecked" : category.isChecked
        ])
    }
    
    func addToDoItem(toDoItem:ToDoItem){
        toDoRef.child(toDoItem.toDoKey).setValue([
            "title" : toDoItem.toDoName,
            "description" : toDoItem.toDoDescription,
            "reminder" : toDoItem.generateStringFromDate(rawDate: toDoItem.toDoRemindDate),
            "creationDate" : toDoItem.generateStringFromDate(rawDate: toDoItem.toDoCreationDate),
            "lastModificationDate" : toDoItem.generateStringFromDate(rawDate: toDoItem.toDoLastModificationDate)
            ])
    }
    
    func removeToDoItem(key:String){
        let toDoItemRef = toDoRef.child(key)
        toDoItemRef.removeValue()
    }
    
    func generateKey(ref:DatabaseReference)->String{
        return ref.childByAutoId().key!
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
    
    func loadAllCategories(tableView : UITableView){
        modelData.categories = [Categories]()
        collectionRef.queryOrdered(byChild: "authorId").queryEqual(toValue: Auth.auth().currentUser?.uid).observe(.value, with: {(snapshot) in
            let categories = snapshot.value as? NSDictionary
            let categoriesKey = categories?.allKeys as! Array<String>
            categoriesKey.map{(singleKey) in
               modelData.categories?.append(self.addCategoryToList(rawData: categories?.object(forKey: singleKey) as! NSDictionary, index: singleKey))
                if(modelData.categories?.count == categories?.count){
                    self.categoriesLoaded = true
                }
            }
            DispatchQueue.main.async {
                tableView.reloadData()
            }
            self.collectionRef.removeAllObservers()
        }) {(error) in
            print("Error : ", error)
        }
    }
    
    func removeCategory(tableView: UITableView, key:String){
        collectionRef.child(key).removeValue()
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
