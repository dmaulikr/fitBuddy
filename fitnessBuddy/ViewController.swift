//
//  ViewController.swift
//  fitnessBuddy
//
//  Created by Darko Dujmovic on 14/04/2017.
//  Copyright © 2017 Darko Dujmovic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var minLablel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        btn.layer.cornerRadius = 20
        backgroundView.layer.cornerRadius = 12
        minLablel.layer.cornerRadius = 20
       
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

