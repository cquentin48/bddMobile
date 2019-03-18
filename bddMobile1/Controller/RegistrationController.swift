//
//  RegistrationController.swift
//  bddMobile1
//
//  Created by lpiem on 18/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit
import FirebaseUI
import Firebase

protocol RegistrationDelegate {
    func didCancel(_ controller:RegistrationController)
    func didRegisterUser(_ controller:RegistrationController, _ user:Profile)
}

class RegistrationController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var delegate:RegistrationDelegate?
    var authUI:FUIAuth?
    
    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var cgu: UILabel!
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cgu.text = "Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression. Le Lorem Ipsum est le faux texte standard de l'imprimerie depuis les années 1500, quand un imprimeur anonyme assembla ensemble des morceaux de texte pour réaliser un livre spécimen de polices de texte. Il n'a pas fait que survivre cinq siècles, mais s'est aussi adapté à la bureautique informatique, sans que son contenu n'en soit modifié. Il a été popularisé dans les années 1960 grâce à la vente de feuilles Letraset contenant des passages du Lorem Ipsum, et, plus récemment, par son inclusion dans des applications de mise en page de texte, comme Aldus PageMaker."
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        //doneButton.isEnabled = false
        // Do any additional setup after loading the view.
    }
    @IBAction func doneActionButton(_ sender: Any) {
        delegate?.didRegisterUser(self, Profile(email: emailInput.text!, password: passwordInput.text!, username: usernameInput.text!))
    }
    @IBAction func cancelActionButton(_ sender: Any) {
        delegate?.didCancel(self)
    }
    
    func imageOnClickListener(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(loadImage(tapGestureRecognizer:)))
        avatarImage.isUserInteractionEnabled = true
        avatarImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @IBAction func usernameInputChanged(_ sender: Any) {
        changeEnableStatusForDoneButton()
    }
    
    @IBAction func passwordInputChanged(_ sender: Any) {
        changeEnableStatusForDoneButton()
    }
    
    @IBAction func emailInputChanged(_ sender: Any) {
        changeEnableStatusForDoneButton()
    }
    @objc func loadImage(tapGestureRecognizer: UITapGestureRecognizer) {
        print("Image tapped")
        /*let action_sheet_vc = UIAlertController(title: "Choisir d'une image", message: "Choisir une image pour son avatar", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Caméra", style: .default, handler: camera_action)
        let gallery = UIAlertAction(title: "Gallerie", style: .default, handler: gallery_action)
        let cancel = UIAlertAction(title: "Annuler", style: .default, handler: nil)
        
        action_sheet_vc.addAction(camera)
        action_sheet_vc.addAction(gallery)
        action_sheet_vc.addAction(cancel)
        
        self.present(action_sheet_vc,animated: true, completion: nil)*/
    }
    
    private func camera_action(action: UIAlertAction){
        
    }
    
    private func gallery_action(action: UIAlertAction){
        
    }
    
    private func changeEnableStatusForDoneButton(){
        doneButton.isEnabled = checkStatusForInput(input: usernameInput) || checkStatusForInput(input: emailInput) || checkStatusForInput(input: passwordInput)
    }
    
    private func checkStatusForInput(input:UITextField)->Bool{
        return !(input.text == "" || input.text == nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
    }
}
