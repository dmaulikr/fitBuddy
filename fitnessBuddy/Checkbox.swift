//
//  Checkbox.swift
//  fitnessBuddy
//
//  Created by Darko Dujmovic on 24/04/2017.
//  Copyright © 2017 Darko Dujmovic. All rights reserved.
//

import UIKit

class CheckBox: UIButton {
    // Images
    let checkedImage = UIImage(named: "checked")! as UIImage
    let uncheckedImage = UIImage(named: "unchecked")! as UIImage
    
    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                UIView.animate(withDuration: 0.1,
                               animations: {
                                self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                                self.setImage(self.checkedImage, for:.normal)
                },
                               completion: { _ in
                                UIView.animate(withDuration: 0.1) {
                                    self.transform = CGAffineTransform.identity
                                }
                })
               
            } else {
                self.setImage(uncheckedImage, for: .normal)
            }
        }
        
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(buttonClicked), for: UIControlEvents.touchUpInside)
        self.isChecked = false
    }
    //kad klikneš metoda vraća stanje u koje button ide
    func buttonClicked(sender: UIButton) -> Bool {
        if sender == self {
            isChecked = !isChecked
            let returnBoolean = Bool(isChecked.description)
            return returnBoolean!
        }
        return false
    }
}
