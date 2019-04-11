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
    }
    
    public init(){
        storage = Storage.storage()
        storageReference = (storage?.reference())!
    }
    
    private func uploadImage(imageName:String, image:UIImage){
        let storageRef = storageReference.child(imageName)
        if let uploadData = image.pngData() {
            storageRef.putData(uploadData, metadata: nil){(metadata, error) in
                guard let metadata = metadata else {
                    // Uh-oh, an error occurred!
                    return
                }
                // You can also access to download URL after upload.
                storageRef.downloadURL { (url, error) in
                    if !(error == nil && url != nil) {
                        print(error.debugDescription)
                    }
                }
            }
        }
    }
    
    public func manageOperations(imagePath:String, image:UIImage = UIImage(), operationType:OperationTypes){
        storageReference.child(imagePath).getMetadata() { (metadata, error) in
            if let error = error{
                print("Error: \(error.localizedDescription)")
                return
            }else{
                switch operationType{
                case .delete: self.removeImage(imageName: imagePath)
                case .insert: self.uploadImage(imageName: imagePath, image: image)
                default: print("Aucune opération")
                }
            }
        }
    }
    
    private func updateImage(imagePath:String, image:UIImage){
        removeImage(imageName: imagePath)
        uploadImage(imageName: imagePath, image: image)
    }
    
    public func removeImage(imageName:String){
        storageReference.child(imageName).delete{ error in
            if error != nil{
                print("Error :"+error.debugDescription)
            }
        }
    }
}
