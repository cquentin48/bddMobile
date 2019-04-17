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
import MaterialComponents.MaterialButtons
import MBProgressHUD

protocol RegistrationDelegate {
    func didCancel(_ controller:RegistrationController)
    func didRegisterUser(_ controller:RegistrationController, _ user:Profile)
}

class RegistrationController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var delegate:RegistrationDelegate?
    var authUI:FUIAuth?
    private var emailOK:Bool = false
    private var passwordOK:Bool = false
    private let emailRegex:String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var cgu: UILabel!
    @IBOutlet weak var cguSwitch: UISwitch!
    
    @IBAction func onAcceptCGUSwitchStateValueChanged(_ sender: Any) {
        updateDoneButtonEnabledStatus()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        cgu.text = "Le Lorem Ipsum est simplement du faux texte employé dans la composition et la mise en page avant impression. Le Lorem Ipsum est le faux texte standard de l'imprimerie depuis les années 1500, quand un imprimeur anonyme assembla ensemble des morceaux de texte pour réaliser un livre spécimen de polices de texte. Il n'a pas fait que survivre cinq siècles, mais s'est aussi adapté à la bureautique informatique, sans que son contenu n'en soit modifié. Il a été popularisé dans les années 1960 grâce à la vente de feuilles Letraset contenant des passages du Lorem Ipsum, et, plus récemment, par son inclusion dans des applications de mise en page de texte, comme Aldus PageMaker."
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        doneButton.isEnabled = false
    }
    @IBAction func doneActionButton(_ sender: Any) {
        delegate?.didRegisterUser(self, Profile(email: emailInput.text!, password: passwordInput.text!))
    }
    
    @IBAction func cancelActionButton(_ sender: Any) {
        delegate?.didCancel(self)
    }
    
    @IBAction func passwordEndEditing(_ sender: Any) {
        if((passwordInput.text?.count)!<10){
            errorToast(text: "Votre mot de passe doit au minimum faire 10 caractères!", textField: passwordInput)
            passwordOK = false
        }else if ((passwordInput.text?.count)!>20){
            errorToast(text: "Votre mot de passe doit au maximum faire 20 caractères!", textField: passwordInput)
            passwordOK = false
        }else{
            correctInput(textField: passwordInput)
            passwordOK = true
        }
        updateDoneButtonEnabledStatus()
    }
    @IBAction func emailEndEditing(_ sender: Any) {
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        if(!emailTest.evaluate(with: emailInput.text)){
            errorToast(text: "Votre adresse mail n'est pas valide!", textField: emailInput)
            emailOK = false
        }else{
            emailOK = true
            correctInput(textField: emailInput)
        }
        updateDoneButtonEnabledStatus()
    }
    
    private func errorToast(text:String, textField:UITextField){
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.borderWidth = 2.0
        displayToast(message: text)
    }
    
    private func correctInput(textField:UITextField){
        textField.layer.borderColor = UIColor.green.cgColor
        textField.layer.borderWidth = 2.0
    }
    
    private func updateDoneButtonEnabledStatus(){
        doneButton.isEnabled = cguSwitch.isOn && passwordOK && emailOK
    }
    
    private func displayToast(message:String){
        let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressHUD.mode = MBProgressHUDMode.text
        progressHUD.detailsLabel.text = message
        progressHUD.margin = 10.0
        progressHUD.offset.y = 150.0
        progressHUD.isUserInteractionEnabled = false
        progressHUD.removeFromSuperViewOnHide = true
        progressHUD.hide(animated: true, afterDelay: 3.0)
    }
}
