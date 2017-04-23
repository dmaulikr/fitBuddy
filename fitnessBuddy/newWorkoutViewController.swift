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
                repsOrDur = false
            }
            else{
                repsOrDurationLabel.text = "Duration"
                repsOrDur = true
            }
        }
    }
    
    //reps = false, duration = true
    var repsOrDur = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        repsOrDurationLabel.text = "Reps"
        createButton.layer.cornerRadius = 12
        
    }

    

    @IBAction func createWorkout(_ sender: Any) {
        
        
        
        if (sets.text?.isEmpty)! {
            
            self.sets.layer.borderColor = UIColor.orange.cgColor
            self.sets.layer.borderWidth = 2
            self.sets.shake()
            self.repsDur.layer.borderColor = UIColor.orange.cgColor
            self.repsDur.layer.borderWidth = 2
            self.repsDur.shake()
            self.workoutName.layer.borderColor = UIColor.orange.cgColor
            self.workoutName.layer.borderWidth = 2
            self.workoutName.shake()
        }
        
        else{
        DispatchQueue.global(qos: .background).async {
        let cdh = coreDataHandler()
        var lstId = cdh.getLastId(forKey: "id")
      
            
            
        let workoutForSaving = workoutModel(wrktDuration: 12, wrktReps: 2, wrktSets: 2, wrktName: self.workoutName.text!, zeroIsRepsOneIsSets: self.repsOrDur, wrktId: lstId)
        
        
        print("You've created a workout \(workoutForSaving.name)that uses \(self.repsDurToggle) value")
     
    
        //input validation za reps dur
        
        //store to core data - OVO STAVI NA BACKGROUND THREAD
     
        print("The last id is \(lstId)")
        
    
        cdh.saveWorkout(workout: workoutForSaving, completion: {
            print("SAVED TO CORE DATA COMPLETION")
            self.tabBarController?.selectedIndex = 0
        })}
        
        //OVO STAVI U COMPLETION - kad kreiraš workout moraš ga switchati na prvi tabview i po mogućnosti obilježi tu novu vježbu
            self.tabBarController?.selectedIndex = 0}
    }
    
    func dismissKeyboard(){
    view.endEditing(true)
    }


}
