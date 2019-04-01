//
//  Database.swift
//  bddMobile1
//
//  Created by lpiem on 01/04/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseUI
let firebaseCloudFirestore = Database()
class Database{
    let db = Firestore.firestore()
    
    func saveCategories(rawCategorie:[Categories]){
        
    }
    
    func initUserDatabase(userId:String){
        let user = db.collection("users").document(userId)
        user.getDocument { (document, error) in
            if let document = document {
                if !document.exists {
                    user.setData([
                        "categories":""
                        ])
                }
            }
        }
    }
}
