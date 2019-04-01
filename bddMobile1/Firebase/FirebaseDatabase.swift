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
        let ref = db.child("collection").child(Auth.auth().currentUser!.uid).ref
        let categoryRef = ref.childByAutoId()
            categoryRef.setValue([
            "title" : category.title!,
            "isChecked" : category.isChecked,
            "image" : category.image!,
            "description" : category.description!,
            "authorId" : Auth.auth().currentUser?.uid
//            "itemList" : category.itemList
        ]) { (error) in
            print("There was an error getting posts", error)
        }
        category.id = categoryRef.key!
    }
    
    func loadAllCategories(){
        let ref = db.child("users").child(Auth.auth().currentUser!.uid).child("collection").ref
        ref.observe(.value, with: {(snapshot) in
            /*snapshot.value as! [String:Any]*/
        }) {(error) in
            print("Error : ", error)
        }
    }
}
