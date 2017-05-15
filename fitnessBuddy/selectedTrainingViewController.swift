//
//  selectedTrainingViewController.swift
//  fitnessBuddy
//
//  Created by Darko Dujmovic on 15/04/2017.
//  Copyright © 2017 Darko Dujmovic. All rights reserved.
//

import UIKit

class selectedTrainingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var listOfExcercises: UITableView!
    @IBOutlet weak var startWorkoutBtn: UIButton!
    @IBOutlet weak var leftBtnConstr: NSLayoutConstraint!
    @IBOutlet weak var btnWidthConstr: NSLayoutConstraint!
    
    
    var availableTrainings = [Workout](){
        didSet{
            for w in availableTrainings {
                print("\n training \(w.name!)")
            }
        }
    }

    @IBAction func closeVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let cdh = coreDataHandler()
        availableTrainings = cdh.loadWorkoutsForTraining(forTraining: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startWorkoutBtn.layer.cornerRadius = 25
        
        startWorkoutBtn.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)

        
        UIView.animate(withDuration: 4, delay: 2, usingSpringWithDamping: 5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: { 
             self.startWorkoutBtn.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
  
        
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableTrainings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listOfExcercises.dequeueReusableCell(withIdentifier: "cell") as! SelectedTrainingTableViewCell
        cell.trainingCellLabel.text = availableTrainings[indexPath.row].name
       // cell?.textLabel?.text = availableTrainings[1].name
        
        return cell
    }
}
