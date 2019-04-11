//
//  ToDoListItemCell.swift
//  bddMobile1
//
//  Created by lpiem on 09/04/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class ToDoListItemCell: UITableViewCell {
    
    @IBOutlet weak var isCheckedLabel: UILabel!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    public func initCell(toDo:ToDoItem){
        categoryTitle.text = toDo.toDoName
        //initIsChecked()
        let url = URL(string: toDo.toDoImageIcon)
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        imageIcon.image = UIImage(data: data!)
        imageIcon.contentMode = .scaleAspectFit
        imageIcon.clipsToBounds = true
    }
    
    /*private func updateSelectedLabel(){
        if(isSelected){
            isCheckedLabel.text = "✓"
        }else{
            isCheckedLabel.text = ""
        }
    }*/

}
