//
//  ItemDetailTableViewController.swift
//  bddMobile1
//
//  Created by lpiem on 22/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit
protocol ItemDetailViewControllerDelegate : class {
    func itemViewControllerDidCancel(_ controller: ItemDetailTableViewController)
    func itemDetailViewController(_ controller: ItemDetailTableViewController, didFinishAddingItem item: Categories)
    func itemDetailViewController(_ controller: ItemDetailTableViewController, didFinishEditingItem item: Categories, indexAt: Int)
}

class ItemDetailTableViewController: UITableViewController, UITextFieldDelegate {
    var delegate : ItemDetailViewControllerDelegate?
    var item:Categories?
    var index:Int?
    
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var categoryDescription: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var itemList: UITableViewCell!
    @IBOutlet weak var doneButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(item == nil){
            self.title = "Nouvel élément"
        }else{
            self.title = item?.title
            titleInput.text = item?.title
            categoryDescription.text = item?.description
        }
        titleInput.becomeFirstResponder()
        initDoneButton()
        addDelegateForTextInput()
    }
    
    func addDelegateForTextInput(){
        titleInput.delegate = self
        titleInput.addTarget(self, action: #selector(initDoneButton), for: .editingChanged)
    }
    
    @objc func initDoneButton(){
        if(titleInput.text == ""){
            doneButton.isEnabled = false
        }else{
            doneButton.isEnabled = true
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        switch indexPath.row{
        case 0:
            return titleInput.frame.size.height
        case 1:
            return categoryDescription.frame.size.height
        case 2:
            return imageView.frame.size.height
        default:
            return 0.0
        }
    }
    
    @IBAction func onDoneAction(_ sender: Any) {
        delegate?.itemViewControllerDidCancel(self)
        if(item == nil){
            delegate?.itemDetailViewController(self, didFinishAddingItem: Categories(title: titleInput.text!, isChecked: false, description: categoryDescription.text))
        }else{
            delegate?.itemDetailViewController(self, didFinishEditingItem: Categories(title: titleInput.text!, isChecked: false, description: categoryDescription.text), indexAt: index!)
        }
    }
    
    @IBAction func onCancelAction(_ sender: Any) {
        delegate?.itemViewControllerDidCancel(self)
    }
}
