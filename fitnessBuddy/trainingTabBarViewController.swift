//
//  trainingTabBarViewController.swift
//  fitnessBuddy
//
//  Created by Darko Dujmovic on 16/04/2017.
//  Copyright © 2017 Darko Dujmovic. All rights reserved.
//

import UIKit

class trainingTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = ScrollingTabBarControllerDelegate()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
