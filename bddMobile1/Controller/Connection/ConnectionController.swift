//
//  ConnectionController.swift
//  bddMobile1
//
//  Created by lpiem on 18/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit
import FirebaseUI
import Firebase
import FirebaseDatabase
import MBProgressHUD

class ConnectionController: UIViewController {
    var authUI:FUIAuth?
    
    @IBAction func connectAction(_ sender: Any) {
        let authUI = FUIAuth.defaultAuthUI()
        
        guard authUI != nil else{
            return
        }
        
        authUI?.delegate = self as FUIAuthDelegate
        let providers:[FUIAuthProvider] = [
            FUIGoogleAuth(),
            FUIFacebookAuth(),
            FUIEmailAuth()
        ]
        authUI?.providers = providers
        
        let authViewController = authUI!.authViewController()
        
        present(authViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        FirebaseApp.configure()
        super.viewDidLoad()
    }
    
    func firebaseUIAuthentification(){
        authUI = FUIAuth.defaultAuthUI()
        authUI!.delegate = self as FUIAuthDelegate
    }
    
    func initFirebaseAuthentificationProvider(){
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth(),
            FUIFacebookAuth(),
            FUIEmailAuth(),
            FUIPhoneAuth(authUI:FUIAuth.defaultAuthUI()!),
            ]
        authUI?.providers = providers
    }
    
    func triggerConnection(){
        authUI?.signIn(withProviderUI: authUI?.providers as! FUIAuthProvider, presenting: self, defaultValue: "")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "register"){
            let navVC = segue.destination as! UINavigationController
            let destVC = navVC.viewControllers.first as! RegistrationController
            destVC.delegate = self
        }
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        if(error != nil){
            print("Error : \(error.debugDescription)")
        }else{
            displayToast(message: "Connection réussie!")
            goToMainStoryboard()
        }
    }
    
    func goToMainStoryboard(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! UINavigationController
        present(vc, animated: true, completion: nil)
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

extension ConnectionController : RegistrationDelegate{
    func didCancel(_ controller: RegistrationController) {
        dismiss(animated: true, completion: nil)
    }
    
    func didRegisterUser(_ controller: RegistrationController, _ user: Profile) {
        let profile = user
        Auth.auth().createUser(withEmail: user.email, password: user.password){ user, error in
            if error == nil && user != nil {
                self.displayToast(message: "Félicitations! Vous voilà inscrit!")
            }else{
                print("Error : \(error?.localizedDescription)")
            }
        }
        dismiss(animated: true, completion: nil)
    }
}

extension ConnectionController : FUIAuthDelegate{
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        guard error == nil else{
            print("Error \(error.debugDescription)")
            return
        }
        
        if error != nil {
            print("Error \(error.debugDescription)")
            return
        }
    }
}
