//
//  GameCell.swift
//  Bout Time
//
//  Created by Muhammad Moaz on 2/1/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import UIKit

class GameCell: UITableViewCell {
    
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var indexLabel: UILabel!
    
    static let identifier: String = String(describing: GameCell.self)
    
    var event: Event? {
        didSet {
            if let event = event {
                self.eventLabel.text = event.text
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
