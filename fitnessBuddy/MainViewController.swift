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
    
    var listOfTrainings = [Training]()
    var listOfTrainingNames = [String](){
        didSet{
            workoutsCollectionView.reloadData()
        }
    }
    
    // end mock trainings 
    /////////////////////////////////////////////////////////////////////////////////////////////////
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let layout = workoutsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let itemWidth = view.bounds.width
            let itemHeight = CGFloat(115)
            layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
            layout.invalidateLayout()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        workoutsCollectionView.reloadData()
        let cdh = coreDataHandler()
        // listOfTrainings = cdh.loadTrainingData()
        listOfTrainingNames = cdh.loadTrainingData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         workoutsCollectionView.frame.size.width = self.view.bounds.width
        

        
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfTrainingNames.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = workoutsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TrainingCollectionViewCell
        cell.cellTrainingTitle.text = listOfTrainingNames[indexPath.row]
        cell.contentView.layer.borderColor = UIColor(red:0.65, green:0.44, blue:0.94, alpha:1.0).cgColor
       // cell.contentView.layer.borderWidth = 1
        
        
        //shadow
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = -1
        cell.layer.shadowOffset = CGSize.zero
        cell.layer.shadowRadius = 100
        
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
