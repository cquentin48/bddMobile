//
//  FirebaseStorage.swift
//  bddMobile1
//
//  Created by lpiem on 11/04/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit
import Firebase

let storage = FirebaseStorage()

class FirebaseStorage{
    let storage:Storage?
    let storageReference:StorageReference
    
    enum OperationTypes {
        case delete
        case update
        case insert
        case select
    }
    
    public init(){
        storage = Storage.storage()
        storageReference = (storage?.reference())!
    }
    
    public func uploadImage(toDoItemAdded:ToDoItem, image:UIImage, categoryId:Int, tableView: UITableView){
        let storageRef = storageReference.child(toDoItemAdded.toDoKey)
        if let uploadData = image.pngData() {
            storageRef.putData(uploadData, metadata: nil){(metadata, error) in
                guard let metadata = metadata else {
                    print("Error : "+error.debugDescription)
                    return
                }
                // You can also access to download URL after upload.
                storageRef.downloadURL { (url, error) in
                    if !(error == nil && url != nil) {
                        print(error.debugDescription)
                    }else{
                        toDoItemAdded.toDoImageIcon = url!.absoluteString
                        DispatchQueue.main.async {
                            firebaseCloudFirestore.addToDoItem(toDoItem: toDoItemAdded, categoryId: modelData.categories![categoryId].id)
                            modelData.addToDoToCollectionList(categoryIndex: categoryId, toDoItem: toDoItemAdded)
                            tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    func loadSingleImage(categoryId:String, cell:ToDoListItemCell){
        let imageRef = storageReference.child(categoryId)
        
        imageRef.getData(maxSize: 1*1024*1024){ data, error in
            if let imageError = error{
                print("Erreur "+imageError.localizedDescription)
            } else {
                cell.imageIcon.image = UIImage(data: data!)
            }
        }
    }
    
    public func removeImage(imageName:String){
        storageReference.child(imageName).delete{ error in
            if error != nil{
                print("Error :"+error.debugDescription)
            }
        }
    }
}
