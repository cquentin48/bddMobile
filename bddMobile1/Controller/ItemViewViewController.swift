//
//  ItemViewViewController.swift
//  bddMobile1
//
//  Created by lpiem on 22/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit
protocol ItemDetailViewControllerDelegate : class {
    func itemViewControllerDidCancel(_ controller: ItemViewViewController)
    func itemDetailViewController(_ controller: ItemViewViewController, didFinishAddingItem item: Categories)
    func itemDetailViewController(_ controller: ItemViewViewController, didFinishEditingItem item: Categories, indexAt: Int)
}

class ItemViewViewController: ViewController {
    var item: Categories?
    var delegate: ItemDetailViewControllerDelegate?
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var navigationView: UINavigationBar!
    
    @IBAction func onCancelAction(_ sender: Any) {
        delegate?.itemViewControllerDidCancel(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(item == nil){
            navigationView.topItem?.title = "Nouvel élément"
        }else{
            navigationView.topItem?.title = item!.title
            titleInput.text = item!.title
        }
        titleInput.becomeFirstResponder()
    }

}
