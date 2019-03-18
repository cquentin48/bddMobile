//
//  CategoryCell.swift
//  bddMobile1
//
//  Created by lpiem on 18/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    @IBOutlet weak var categoryCellTextView: UILabel!
    @IBOutlet weak var categoryIsChecked: UILabel!
    
    func initCell(categoryName:String, isChecked:Bool){
        initCellText(categoryName: categoryName)
        initToggle(isToogle: isChecked)
    }
    
    func initCellText(categoryName:String){
        categoryCellTextView.text = categoryName
    }
    
    func initToggle(isToogle:Bool){
        if(isToogle){
            categoryIsChecked.text = "✓"
        }else{
            categoryIsChecked.text = ""
        }
    }
}
