//
//  extensionsForViewController.swift
//  fitnessBuddy
//
//  Created by Darko Dujmovic on 16/04/2017.
//  Copyright © 2017 Darko Dujmovic. All rights reserved.
//

import UIKit

class extensionsForViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

 
  

}

extension UIViewController {

//    func addGestureRecognizerAndDismissFirstResponder(forViewController VC:UIViewController){
//        
//        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: VC, action: #selector("dismissFirstResponder"))
//        VC.addGestureRecognizer(tapGestureRecognizer)
//        
//        
//    }

}

extension UIView{
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = CGPoint(x: self.center.x - 10, y:self.center.y)
        animation.toValue = CGPoint(x: self.center.x + 10, y:self.center.y)
        self.layer.add(animation, forKey: "position")
    }
    func shake2() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.06
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = CGPoint(x: self.center.x - 15, y:self.center.y)
        animation.toValue = CGPoint(x: self.center.x + 15, y:self.center.y)
        self.layer.add(animation, forKey: "position")
    }


}
