//
//  NoteTableViewCell.swift
//  Notas
//
//  Created by jose luis sanchez-porro godoy on 16/01/2017.
//  Copyright © 2017 jose luis sanchez-porro godoy. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    
    @IBOutlet var imageCell: UIImageView!
    
    @IBOutlet weak var dateCell: UILabel!
    
    @IBOutlet weak var textCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
