//
//  newWorkoutViewController.swift
//  fitnessBuddy
//
//  Created by Darko Dujmovic on 16/04/2017.
//  Copyright © 2017 Darko Dujmovic. All rights reserved.
//

import UIKit

class newWorkoutViewController: UIViewController {

    @IBOutlet weak var workoutName: UITextField!
    @IBOutlet weak var sets: UITextField!
    @IBOutlet weak var repsDur: UITextField!
    @IBOutlet weak var repsDurToggle: UISegmentedControl!
    
    @IBOutlet weak var repsOrDurationLabel: UILabel!
    
    @IBAction func repsDurToggleAction(_ sender: UISegmentedControl) {
        selectedIndexRepsDur = sender.selectedSegmentIndex
        print("Selected segment index is \(sender.selectedSegmentIndex)")
    }
 
    @IBOutlet weak var createButton: UIButton!
    
    var selectedIndexRepsDur = 0{
        didSet{
            if selectedIndexRepsDur == 0{
                repsOrDurationLabel.text = "Reps"
            }
            else{
                repsOrDurationLabel.text = "Duration"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        repsOrDurationLabel.text = "Reps"
        createButton.layer.cornerRadius = 12
        
    }

    @IBAction func createWorkout(_ sender: Any) {
        
        let workoutForSaving = workoutModel(wrktDuration: 12, wrktReps: 2, wrktSets: 2, wrktName: self.workoutName.text!, zeroIsRepsOneIsSets: true)
        
        
        print("You've created a workout \(workoutForSaving.name)that uses \(repsDurToggle) value")
     
    
        //input validation za reps dur
        
        //store to core data - OVO STAVI NA BACKGROUND THREAD
        let cdh = coreDataHandler()
        var lstId = cdh.getLastId(forKey: "id")
        print("The last id is \(lstId)")
        
        //OVO STAVI U COMPLETION - kad kreiraš workout moraš ga switchati na prvi tabview i po mogućnosti obilježi tu novu vježbu
        self.tabBarController?.selectedIndex = 0
    
    }
    
    func dismissKeyboard(){
    view.endEditing(true)
    }


}
