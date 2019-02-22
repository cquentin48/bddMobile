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
        }
    }
    
    @IBAction func onCancelAction(_ sender: Any) {
        delegate?.itemViewControllerDidCancel(self)
    }
    
    
    
    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
