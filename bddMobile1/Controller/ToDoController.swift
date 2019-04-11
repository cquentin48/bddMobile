//
//  ToDoController.swift
//  bddMobile1
//
//  Created by lpiem on 08/04/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

protocol ToDoDelegate{
    func didAddItem(_ controller:ToDoController, itemAdded:ToDoItem)
    
    func cancel(_ controller: ToDoController)
}

class ToDoController: UITableViewController {

    @IBOutlet weak var reminderTitle: UITextField!
    @IBOutlet weak var categoriesPickerView: UIPickerView!
    @IBOutlet weak var reminderDescription: UITextField!
    @IBOutlet weak var reminderDate: UIDatePicker!
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var lastModificationDateLabel: UILabel!
    
    private var toDoObjectId:Int = -1
    private var toDoCategoryList:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    private func initElements(){
        if(!isNotCreated()){
            reminderTitle.text = modelData.categories![toDoCategoryList].itemList![toDoObjectId].toDoName
        }
    }
    
    private func formatDate()->String{
        //let dateTimeFormatter = DateFormatter()
        return ""
    }
    
    private func isNotCreated() ->Bool{
        return toDoObjectId == -1
    }
}
