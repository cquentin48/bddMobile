//
//  ToDoListItemCell.swift
//  bddMobile1
//
//  Created by lpiem on 09/04/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class ToDoListItemCell: UITableViewCell {
    
    @IBOutlet weak var isChecked: UILabel!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    private func updateSelectedLabel(){
        if(isSelected){
            
        }
    }

}