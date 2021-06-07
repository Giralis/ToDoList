//
//  ToDoTableViewCell.swift
//  ToDoList
//
//  Created by Владимир Тимофеев on 30.05.2021.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
       
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func update(with toDo: ToDo) {
        nameLabel.text = toDo.name
        dateLabel.text = toDo.date.description
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
           // Configure the view for the selected state
    }
}
