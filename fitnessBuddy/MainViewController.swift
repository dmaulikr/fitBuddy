//
//  MainViewController.swift
//  fitnessBuddy
//
//  Created by Darko Dujmovic on 15/04/2017.
//  Copyright © 2017 Darko Dujmovic. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var workoutsCollectionView: UICollectionView!
    @IBOutlet weak var headerView: UIView!
    
    let trainings = [Training]()
    
    //create mock trainings
    
     var training1 = mockTraining(nameOfExcercise: "Push", intensity: 1)
     var training2 = mockTraining(nameOfExcercise: "Pull", intensity: 4)
     var training3 = mockTraining(nameOfExcercise: "Cardio", intensity: 2)
     var training4 = mockTraining(nameOfExcercise: "HIIT", intensity: 3)
     var training5 = mockTraining(nameOfExcercise: "Back day", intensity: 5)
    
    var colorCoordination = [UIColor]()
    
    func appendColors(){
        colorCoordination.append(UIColor.black)
//        colorCoordination.append()
//        colorCoordination.append()
//        colorCoordination.append()
//        colorCoordination.append()
    }

    
    var mockTrainings = ["Push","Pull","Legs","Cardio","Accessories","HIIT","Backday"]
    var listOfTrainings = [Training]()
    
    // end mock trainings 
    /////////////////////////////////////////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
         workoutsCollectionView.frame.size.width = self.view.bounds.width
         let cdh = coreDataHandler()
        listOfTrainings = cdh.loadTrainingData()
     
        
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mockTrainings.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.maxX/3, height: self.view.bounds.maxY/6);
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.width
        let itemHeight = collectionView.bounds.height
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = workoutsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TrainingCollectionViewCell
        cell.cellTrainingTitle.text = mockTrainings[indexPath.row]
        cell.contentView.layer.borderColor = UIColor(red:0.65, green:0.44, blue:0.94, alpha:1.0).cgColor
       // cell.contentView.layer.borderWidth = 1
        
        
        //shadow
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = -1
        cell.layer.shadowOffset = CGSize.zero
        cell.layer.shadowRadius = 10
        
        //cornerRadius
        cell.layer.cornerRadius = 2
        cell.layer.masksToBounds = true
        
        //cell.frame.width = self.view.bounds.maxX
        return cell
    }
    
    class mockTraining:NSObject{
        let title:String?
        let intensity:Int?
        init(nameOfExcercise title:String, intensity: Int){
            self.title = title
            self.intensity = intensity
        }
    }
    @IBAction func test(_ sender: Any) {
        print("Called")
        
        for tr in listOfTrainings{
           
            
            print("tr \(tr.name!) with \(tr.id) \n")
            print("Setted \(Set(listOfTrainings))")
        }
        
    }

}
