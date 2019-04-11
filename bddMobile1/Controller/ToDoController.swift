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

class ToDoController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

    @IBOutlet weak var reminderTitle: UITextField!
    @IBOutlet weak var categoriesPickerView: UIPickerView!
    @IBOutlet weak var reminderDescription: UITextField!
    @IBOutlet weak var reminderDate: UIDatePicker!
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var lastModificationDateLabel: UILabel!
    
    private var toDoObjectId:Int = -1
    private var toDoCategoryList:Int = 0
    private var pickerViewList:Array<String>?
    
    var delegate:ToDoDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPicker()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func onDoneAction(_ sender: Any) {
        delegate?.cancel(self)
    }
    
    @IBAction func onCancelAction(_ sender: Any) {
        delegate?.cancel(self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func loadPicker(){
        pickerViewList = modelData.loadCategoryTitles()
    }
    
    private func initElements(){
        if(!isNotCreated()){
            reminderTitle.text = modelData.categories![toDoCategoryList].itemList![toDoObjectId].toDoName
        }else{
            initElements()
        }
    }
    
    private func initNewElement(){
        self.title = "Nouvel élément"
        creationDateLabel.text = ""
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerViewList!.count
    }
    
    private func formatDate()->String{
        //let dateTimeFormatter = DateFormatter()
        return ""
    }
    
    private func isNotCreated() ->Bool{
        return toDoObjectId == -1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewList![row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
}
