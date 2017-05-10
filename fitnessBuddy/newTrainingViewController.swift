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
    @IBOutlet weak var trainingNameLbl: UITextField!
   
   // let selectionButton = CheckBox()
    
    @IBAction func closeWindow(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var isSuccessfullySaved = false{
        didSet{
            print("successfully saved")
            //self.view.removeFromSuperview()
            self.closeWindow(self)
        }
    }
    
    enum cells:String {
        case workoutsTableViewCell = "cell"
    }


    @IBOutlet weak var createBtn: UIButton!

    
    var availableWorkouts = [Workout](){
        didSet{
            availableWorkouts.sort{$0.name! < $1.name!}
            for workout in availableWorkouts {
                print("\(workout.id) and  \(String(describing: workout.name))")
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
        //let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        //let tapTable: UITapGestureRecognizer = UITapGestureRecognizer(target: self.workoutsTableView, action: #selector(markRow))
       // view.addGestureRecognizer(tap)
        let cdh = coreDataHandler()
        availableWorkouts = cdh.loadCoreData()
        workoutsTableView.allowsMultipleSelection = true
    
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
            //cell.repsOrDurLabel.text = "Reps"
        }else{
           // cell.repsOrDurLabel.text = "Dur"
        }
        cell.repsDurNum.text = String(workoutToShow.defReps)
 
        
        let selectedIndexPaths = tableView.indexPathsForSelectedRows
        let rowIsSelected = selectedIndexPaths != nil && selectedIndexPaths!.contains(indexPath)
        cell.accessoryType = rowIsSelected ? .checkmark : .none
        
        cell.selectionStyle = .none
        
        return cell
    }


    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = workoutsTableView.cellForRow(at: indexPath) as? addTrainingTableViewCell{
            //  cell.workoutSelectionIndicator.isChecked = !cell.workoutSelectionIndicator.isChecked
            cell.accessoryType = .checkmark
            print("Selected")
        }else{
            print("Unselected")
            
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = workoutsTableView.cellForRow(at: indexPath) as? addTrainingTableViewCell{
            //cell.workoutSelectionIndicator.isChecked = !cell.workoutSelectionIndicator.isChecked
            cell.accessoryType = .none
            print("Selected")
        }else{
            print("Unselected")
        }
    }
    
    func getSelectedRowsAndStoreIntoArray(){
    
    }
    
    
    @IBAction func createTraining(_ sender: Any) {
        
        guard let selectedRowsData = workoutsTableView.indexPathsForSelectedRows else {
            print("No rows selected")
            //alert user
            return
        }
      
        var selectedRows = [Int]()
        var selectedWorkoutIDs = [Int]()
        
        for row in selectedRowsData {
            print("Row \(row[1]) \n")
                selectedRows.append(row[1])
        }
        
        
        //we need to go deeper
        for selectedWorkout in selectedRows{
            selectedWorkoutIDs.append(Int(availableWorkouts[selectedWorkout].id))
            
            let workoutID = Int(availableWorkouts[selectedWorkout].id)
            
            let training = trainingModel(trainingDuration: 0, durSet: false, name: trainingNameLbl.text! , reps: 10, sets: 10, trainingId: 1, workoutID: Int32(workoutID))
            
            
            
            let cdh = coreDataHandler()
            //cdh.saveTraining(training: training)
            
            self.isSuccessfullySaved = cdh.saveTraining(training: training)
        }
    }
    
    
    
    
    @IBAction func zipRecruiter(_ sender: Any) {
        
        self.dismissKeyboard()
    }

   
}
