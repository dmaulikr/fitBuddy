//
//  newWorkoutViewController.swift
//  fitnessBuddy
//
//  Created by Darko Dujmovic on 16/04/2017.
//  Copyright © 2017 Darko Dujmovic. All rights reserved.
//

import UIKit

class newWorkoutViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var workoutName: UITextField!
    @IBOutlet weak var sets: UITextField!
    @IBOutlet weak var repsDur: UITextField!
    @IBOutlet weak var repsDurToggle: UISegmentedControl!
    @IBOutlet weak var repsOrDurationLabel: UILabel!

    var reps:Int32?
    var duration:Double?
    var setsNo:Int32?
    
    var isSuccessfullySaved = false{
        didSet{
            print("successfully saved")
          
                print("Everything is saved, do something now")
                let a = coreDataHandler()
                a.loadCoreData()
        
            
        }
    }
    
    var isSuccessfullyLoaded = false{
        didSet{
        
            
        }
    }
    
    
    enum CoreDataStrings:String {
        case ID = "id"
    }
    
    var isCoreDataStoringFinished = false {
        didSet{
            print("\n ***** Bool is set to \(isCoreDataStoringFinished) \n")
          //  reloadTrainingViewTV(completion: nil)
        }
    }
    
    @IBAction func repsDurToggleAction(_ sender: UISegmentedControl) {
        selectedIndexRepsDur = sender.selectedSegmentIndex
        print("Selected segment index is \(sender.selectedSegmentIndex)")
        if selectedIndexRepsDur == 1 {
            duration = Double(repsDur.text!)
            setsNo = Int32(sets.text!)
            reps = 0
        }else{
            reps = Int32(repsDur.text!)
            setsNo = Int32(sets.text!)
            duration = 0
        
        }
        
        
        
        
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
        let lstId = cdh.getLastId(forKey: CoreDataStrings.ID.rawValue)
        let workoutId = Int32(lstId+1)
    
            
        let workoutForSaving = workoutModel(wrktDuration: self.duration!, wrktReps: self.reps!, wrktSets: self.setsNo!, wrktName: self.workoutName.text!, zeroIsRepsOneIsSets: false, wrktId: workoutId)
            
        //store to core data - OVO STAVI NA BACKGROUND THREAD
        
        // VRATI SE NA MAIN THREAD DA MOŽEŠ RADITI AKTIVNOSTI PO VIEWU
        self.isSuccessfullySaved = cdh.saveWorkout(workout: workoutForSaving, completion: {
                    print("\n I am done after workout is saved")
                }())
            
            }
        }
        
    }
    
    func reloadTrainingViewTV(completion:()){
//        let targetTabVC = self.tabBarController?.childViewControllers.first as! newTrainingViewController
//        targetTabVC.workoutsTableView.delegate = self
//        let a = coreDataHandler()
//        a.loadCoreData()
        //targetTabVC.workoutsTableView.reloadData()
    
    }
    
    func dismissKeyboard(){
    view.endEditing(true)
    }


}
