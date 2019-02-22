//
//  TableViewCellController.swift
//  bddMobile1
//
//  Created by lpiem on 22/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class TableViewCellController: UITableViewCell {
    @IBOutlet weak var isChecked: UILabel!
    @IBOutlet weak var checkListName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func initCell(inputCheckList: Categories){
        checkListName.text = inputCheckList.title
        if(inputCheckList.isChecked){
            isChecked.text = "✓"
        }else{
            isChecked.text = "𐄂"
        }
    }
}
