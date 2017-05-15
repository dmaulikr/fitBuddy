//
//  newWorkoutViewController.swift
//  fitnessBuddy
//
//  Created by Darko Dujmovic on 16/04/2017.
//  Copyright © 2017 Darko Dujmovic. All rights reserved.
//

import UIKit

class newWorkoutViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate {

    //outlets
    @IBOutlet weak var workoutName: UITextField!
    @IBOutlet weak var sets: UITextField!
    @IBOutlet weak var repsDur: UITextField!
    @IBOutlet weak var repsDurToggle: UISegmentedControl!
    @IBOutlet weak var repsOrDurationLabel: UILabel!

    //local variables
    var reps:Int32 = 0
    var duration:Double = 0
    var setsNo:Int32 = 0
    
    
    //when core data saves I want to refresh the training data, tableview and switch to that tabbar
    var isSuccessfullySaved = false{
        didSet{
            print("successfully saved")
                //self.view.removeFromSuperview()
                self.tabBarController?.selectedIndex = 0
        }
    }
    
    var isSuccessfullyLoaded = [Workout](){
        didSet{
            //reloadTrainingViewTV()
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
            if !(repsDur.text?.isEmpty)!{
            duration = Double(repsDur.text!)!
            setsNo = Int32(self.sets.text!)!
                reps = 0}
        }else{
            reps = Int32(repsDur.text!)!
            setsNo = Int32(self.sets.text!)!
            duration = 0
        
        }
        
        
        
        
    }
 
    @IBOutlet weak var createButton: UIButton!
    
    //reps = false, duration = true
    var repsOrDur = false
    
    var selectedIndexRepsDur = 0 {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        clearAllInputFields()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        repsOrDurationLabel.text = "Reps"
        createButton.layer.cornerRadius = 12
        
    
    }

    

    @IBAction func createWorkout(_ sender: Any) {
        
        
        if (sets.text?.isEmpty)! {
            animateFields()
        }
        
        else{
            
        let cgFrame = CGRect(x: 12, y: 100, width: 100, height: 100)
        let activityView = UIView(frame: cgFrame)
        self.view.insertSubview(activityView, aboveSubview: self.view)
            
            
        DispatchQueue.global(qos: .userInitiated).sync {
        let cdh = coreDataHandler()
        let lstId = cdh.getLastId(forKey: CoreDataStrings.ID.rawValue)
        let workoutId = Int32(lstId+1)
        let setsNum = Int32(self.sets.text!)!
            

        let workoutForSaving = workoutModel(wrktDuration: self.duration, wrktReps: self.reps, wrktSets: setsNum, wrktName: self.workoutName.text!, zeroIsRepsOneIsSets: self.repsOrDur, wrktId: workoutId)

            
        self.isSuccessfullySaved = cdh.saveWorkout(workout: workoutForSaving, completion: {
                    print("\n I am done after workout is saved")
                }())
            
            }
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Editing a textfield")
    }
    
    
    func animateFields(){

        self.view.addBorderToTextField(textfield: self.sets, withColor: UIColor.orange.cgColor, withBorder: 2)
        self.sets.shake()
        self.view.addBorderToTextField(textfield: self.repsDur, withColor: UIColor.orange.cgColor, withBorder: 2)
        self.repsDur.shake()
        self.view.addBorderToTextField(textfield: self.workoutName, withColor: UIColor.orange.cgColor, withBorder: 2)
        self.workoutName.shake()
    }
    
    func clearAllInputFields(){
        workoutName.text = ""
        sets.text = ""
        repsDur.text = ""
        
        self.view.removeBorderFromTextField(textfield: workoutName)
        self.view.removeBorderFromTextField(textfield: sets)
        self.view.removeBorderFromTextField(textfield: repsDur)
    }

    
    func dismissKeyboard(){
    view.endEditing(true)
    }


}
