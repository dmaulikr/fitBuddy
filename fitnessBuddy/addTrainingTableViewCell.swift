//
//  addTrainingTableViewCell.swift
//  fitnessBuddy
//
//  Created by Darko Dujmovic on 16/04/2017.
//  Copyright © 2017 Darko Dujmovic. All rights reserved.
//

import UIKit

class addTrainingTableViewCell: UITableViewCell {

    @IBOutlet weak var workoutTitle: UILabel!
    @IBOutlet weak var workoutSelectionIndicator: CheckBox!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    


}
