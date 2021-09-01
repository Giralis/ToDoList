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
    
    func update(with toDo: ToDoStr) {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        
        nameLabel.text = toDo.name
        dateLabel.text = formatter.string(from: toDo.date)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
           // Configure the view for the selected state
    }
}
