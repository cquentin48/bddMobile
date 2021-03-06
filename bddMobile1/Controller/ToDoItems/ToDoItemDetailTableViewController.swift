//
//  ToDoController.swift
//  bddMobile1
//
//  Created by lpiem on 08/04/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

protocol ToDoDelegate{
    func didAddItem(controller:ToDoItemDetailTableViewController, itemAdded:ToDoItem, categoryIdString:String, image:UIImage)
    
    func cancel(controller: ToDoItemDetailTableViewController)
}

class ToDoItemDetailTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

    @IBOutlet weak var reminderTitle: UITextField!
    @IBOutlet weak var categoriesPickerView: UIPickerView!
    @IBOutlet weak var reminderDescription: UITextField!
    @IBOutlet weak var reminderDate: UIDatePicker!
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var lastModificationDateLabel: UILabel!
    @IBOutlet weak var toDoIcon: UIImageView!
    @IBOutlet weak var imageChosenButton: UIButton!
    
    private var toDoObjectId:Int = -1
    var toDoCategoryList:Int = 0
    private var pickerViewList:[String]?
    private var toDo:ToDoItem?
    private var tapGesture:UITapGestureRecognizer?
    
    private var imagePicker = UIImagePickerController()
    
    var delegate:ToDoDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initPickerView()
        initImagePicker()
        generateModel()
        initNewElement()
        reminderDescription.text = String(toDoCategoryList)
    }
    
    private func initPickerView(){
        loadPicker()
        categoriesPickerView.delegate = self
        categoriesPickerView.dataSource = self
    }
    
    private func initImagePicker(){
        imagePicker.delegate = self
    }
    
    private func generateModel(){
        toDo = ToDoItem()
        toDo?.toDoKey = (toDo?.generateKey())!
    }
    
    @IBAction func onDoneAction(_ sender: Any) {
        updateModel()
        delegate?.didAddItem(controller: self, itemAdded: toDo!, categoryIdString: modelData.categories![toDoCategoryList].id, image: toDoIcon.image!)
    }
    
    private func updateModel(){
        toDo?.toDoName = reminderTitle.text!
        toDo?.toDoDescription = reminderDescription.text!
        toDo?.toDoRemindDate = reminderDate.date
        toDo?.toDoCreationDate = Date()
        toDo?.toDoLastModificationDate = Date()
    }
    
    @IBAction func onCancelAction(_ sender: Any) {
        delegate?.cancel(controller: self)
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
        return 1
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
        return pickerViewList!.count
    }
    
    func loadImageMessageDialog(){
        let alert = UIAlertController(title: "Choix d'un image", message: "Veuillez choisir une image pour ce qui est à faire.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Passage par la gallerie", style: .default, handler: { action in
            self.loadGallery()
        }))
        alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }

    
    @IBAction func chooseImage(_ sender: Any) {
        loadImageMessageDialog()
    }
}

extension ToDoItemDetailTableViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func loadGallery(){
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker,animated: true,completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            toDoIcon.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
