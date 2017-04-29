//
//  newTrainingViewController.swift
//  fitnessBuddy
//
//  Created by Darko Dujmovic on 16/04/2017.
//  Copyright © 2017 Darko Dujmovic. All rights reserved.
//

import UIKit

class newTrainingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var workoutCell: addTrainingTableViewCell!
    @IBOutlet weak var workoutsTableView: UITableView!
   
    let selectionButton = CheckBox()
    
    @IBAction func closeWindow(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    enum cells:String {
        case workoutsTableViewCell = "cell"
    }


    @IBOutlet weak var createBtn: UIButton!
    //fetch workouts in array
//    var mockWorkoutsOfTraining = ["Benchpress","Incline bench press","Dumbell incline press","Dumbbell spread","Dips","Frenchpress","Biceps","Cable shoulder pull","Squats", "Legpress", "Lunges","Romanian deadlift", "Pull ups","Deadlift", "Biceps curl"]
    
    var availableWorkouts = [Workout](){
        didSet{
           // mockWorkoutsOfTraining.sort{$0 < $1}
            for workout in availableWorkouts {
                print("\(workout.id) and  \(workout.name)")
            }
            workoutsTableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("\n ******* View will appear \n")
        let a = coreDataHandler()
        availableWorkouts = a.loadCoreData()
       // self.workoutsTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workoutsTableView.reloadData()
        createBtn.layer.cornerRadius = 12
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        let cdh = coreDataHandler()
        availableWorkouts = cdh.loadCoreData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return availableWorkouts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let workoutToShow = availableWorkouts[indexPath.row]
        let cell = workoutsTableView.dequeueReusableCell(withIdentifier: cells.workoutsTableViewCell.rawValue) as! addTrainingTableViewCell
        cell.workoutTitle.text = workoutToShow.name!
        cell.setsNum.text = String(workoutToShow.defSets)
        if !workoutToShow.repSet{
            cell.repsOrDurLabel.text = "Reps"
        }else{
            cell.repsOrDurLabel.text = "Dur"
        }
        cell.repsDurNum.text = String(workoutToShow.defReps)
        
        let isSelected = cell.workoutSelectionIndicator
        if (isSelected?.isChecked)!{
            print ("The cell \(cell.workoutTitle.text!) is selected\n")
        }else{
            print ("The cell \(cell.workoutTitle.text!) is not selected\n")
        }
        return cell
    }
    func dismissKeyboard(){
        view.endEditing(true)
    }
    @IBAction func createTraining(_ sender: Any) {
        
        
        
    }
  
   
}
