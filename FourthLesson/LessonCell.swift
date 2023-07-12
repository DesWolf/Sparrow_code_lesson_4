//
//  LessonCell.swift
//  FourthLesson
//
//  Created by Максим Окунеев on 10.07.2023.
//

import UIKit

class LessonCell: UITableViewCell {
    
//    override func awakeFromNib() {
//          super.awakeFromNib()
//          self.selectionStyle = .none
//      }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        accessoryType = selected ? .checkmark : .none
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        UIView.animate(withDuration: 0.5) {
            self.backgroundColor = highlighted ? .systemGray5 : .clear
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.textLabel?.text = ""
        accessoryType = .none
    }
}
