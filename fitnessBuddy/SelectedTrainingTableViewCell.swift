//
//  SelectedTrainingTableViewCell.swift
//  fitnessBuddy
//
//  Created by Darko Dujmovic on 15/05/2017.
//  Copyright © 2017 Darko Dujmovic. All rights reserved.
//

import UIKit

class SelectedTrainingTableViewCell: UITableViewCell {

    @IBOutlet weak var trainingCellLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
