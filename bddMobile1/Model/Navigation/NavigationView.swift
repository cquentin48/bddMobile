//
//  NavigationView.swift
//  bddMobile1
//
//  Created by lpiem on 18/04/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit
import SideMenu

class NavigationView{
    let menuLeftNavigationController:UISideMenuNavigationController?
    
    required init() {
        menuLeftNavigationController = UISideMenuNavigationController(rootViewController: NavigationOptionsController())
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
    }
}
