//
//  NavigationOptionsController.swift
//  bddMobile1
//
//  Created by lpiem on 18/04/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit
import SideMenu
import FirebaseAuth

class NavigationOptionsController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return super.numberOfSections(in: tableView)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return super.tableView(tableView, numberOfRowsInSection: section)
    }
    
    func onActionChange(){
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    @IBAction func loggingOut(_ sender: Any) {
        loggout()
    }
    
    @IBAction func tasksToDo(_ sender: Any) {
        onActionChange()
    }
    
    @IBAction func categoriesList(_ sender: Any) {
        onActionChange()
    }
    
    func loggout(){
        do
        {
            try Auth.auth().signOut()
            let storyboard = UIStoryboard(name: "ConnectionScreen", bundle: nil)
            let vc = storyboard.instantiateInitialViewController() as! UINavigationController
            present(vc, animated: true, completion: nil)
        }
        catch let error as NSError
        {
            print (error.localizedDescription)
        }        
    }
}

extension NavigationOptionsController: UISideMenuNavigationControllerDelegate {
    func sideMenuWillAppear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Appearing! (animated: \(animated))")
    }
    
    func sideMenuDidAppear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Appeared! (animated: \(animated))")
    }
    
    func sideMenuWillDisappear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappearing! (animated: \(animated))")
    }
    
    func sideMenuDidDisappear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappeared! (animated: \(animated))")
    }
}
