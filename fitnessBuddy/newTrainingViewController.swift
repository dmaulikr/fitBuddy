//
//  newTrainingViewController.swift
//  fitnessBuddy
//
//  Created by Darko Dujmovic on 16/04/2017.
//  Copyright © 2017 Darko Dujmovic. All rights reserved.
//

import UIKit

class newTrainingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var workoutsTableView: UITableView!
    
    @IBAction func closeWindow(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBOutlet weak var createBtn: UIButton!
    //fetch workouts in array
//    var mockWorkoutsOfTraining = ["Benchpress","Incline bench press","Dumbell incline press","Dumbbell spread","Dips","Frenchpress","Biceps","Cable shoulder pull","Squats", "Legpress", "Lunges","Romanian deadlift", "Pull ups","Deadlift", "Biceps curl"]
    var mockWorkoutsOfTraining = [Workout](){
        didSet{
           // mockWorkoutsOfTraining.sort{$0 < $1}
            workoutsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createBtn.layer.cornerRadius = 12
        let cdh = coreDataHandler()
        mockWorkoutsOfTraining = cdh.loadCoreData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockWorkoutsOfTraining.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = workoutsTableView.dequeueReusableCell(withIdentifier: "cell") as! addTrainingTableViewCell
        cell.workoutTitle.text = mockWorkoutsOfTraining[indexPath.row].name!//
        return cell
    }
   
}
