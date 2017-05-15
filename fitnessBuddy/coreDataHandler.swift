//
//  coreDataHandler.swift
//  restauranter
//
//  Created by Darko Dujmovic on 03/04/2017.
//  Copyright © 2017 Darko Dujmovic. All rights reserved.
//

import UIKit
import CoreData

// TODO - enums for generic fetch from core data
enum entities:String {
    case training = "Training"
    case workout = "Workout"
}

class coreDataHandler: NSObject {


   // var lastID:Int32 = 0

    func saveWorkout (workout: workoutModel, completion:()) -> Bool{
       
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Workout", in: managedContext)
        let wrkt = NSManagedObject(entity: entity!, insertInto: managedContext)
        wrkt.setValue(workout.wrktId, forKey: "id")
        wrkt.setValue(workout.name, forKey: "name")
        wrkt.setValue(workout.repSet, forKey: "repSet")
        wrkt.setValue(workout.defDur, forKey: "defDur")
        wrkt.setValue(workout.defSets, forKey: "defSets")
        wrkt.setValue(workout.defReps, forKey: "defReps")
        
        print("\n ***** Core data saving ***** \n")
        
        
        do{
            try managedContext.save()
            return true
        
        }catch let error as NSError{
            print("Can't save due to \(error)")
            return false
        }
    }
    
    
    //make this generic
    func loadCoreData()->[Workout]{
        
        var workouts = [Workout]()
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let managedContext = appDelegate?.persistentContainer.viewContext
        
        do{
            let fetchRequest : NSFetchRequest<Workout> = Workout.fetchRequest()
            
            let result = try managedContext?.fetch(fetchRequest)
            print("loaded core data")
            for wrkt in result! {
                workouts.append(wrkt)
            }
          //  self.lastID = (restaurants.last?.id)!
        
            return workouts
            
        }
        catch {
            fatalError("Error while trying to get core data")
        }
        return workouts
    }
    
    func getLastId(forKey key: String)->Int32{
        
        var lastId = Int32()
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext =  appDelegate?.persistentContainer.viewContext
        do{
            let fetchRequest : NSFetchRequest<Workout> = Workout.fetchRequest()
            fetchRequest.fetchLimit = 1
            let sortDescriptor = NSSortDescriptor(key: key, ascending: false)
            fetchRequest.sortDescriptors = [sortDescriptor]
            let result = try managedContext?.fetch(fetchRequest)
            for rest in result!{
                lastId = rest.id
            }
            return lastId
        } catch{
            print("Can't get last ID")
        }
        return lastId
    }
    
    func getLastIdTraining(forKey key: String)->Int32{
        
        var lastId = Int32()
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext =  appDelegate?.persistentContainer.viewContext
        do{
            let fetchRequest : NSFetchRequest<Training> = Training.fetchRequest()
            fetchRequest.fetchLimit = 1
            let sortDescriptor = NSSortDescriptor(key: key, ascending: false)
            fetchRequest.sortDescriptors = [sortDescriptor]
            let result = try managedContext?.fetch(fetchRequest)
            for rest in result!{
                lastId = rest.id
            }
            return lastId
        } catch{
            print("Can't get last ID")
            return 0
        }
        return lastId
    }
    
    
    // TRAINING
    
    //load distinct trainings for collectionview list
    func loadTrainingData()->[String]{
        
        var trainings = [String]()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate?.persistentContainer.viewContext
        
        do{
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Training")
            fetchRequest.resultType = .dictionaryResultType
            fetchRequest.propertiesToFetch = ["name"]
            fetchRequest.returnsDistinctResults = true

            
            if let result = try managedContext?.fetch(fetchRequest) as? [Dictionary<String, String>] {
                for r in result{
                    //  print(" \n ----- \(String(describing: r["id"]!))  ---- \(String(describing: r["name"]!))")
                    let trainingName = String(describing: r["name"]!)
                    trainings.append(trainingName)
                }
            }
            return trainings
            }
        catch {
            fatalError("Error while trying to get core data")
        }
        return trainings
    }
    
    
    func saveTraining (training: trainingModel)->Bool {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Training", in: managedContext)
        let trnng = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        trnng.setValue(training.name, forKey: "name")
        trnng.setValue(training.trainingId, forKey: "id")
        
        print("\n ***** Core data saving ***** \n")
        
        
        do{
            try managedContext.save()
            return true
            
        }catch let error as NSError{
            return false
         
    
        }
    }

    
    //SHOW TRAINING
    
    //dohvati idjeve workouta pa onda novi fetch -- trebaš vratiti workouts
    
    //1. dohvati training id -- imamo ga iz poziva
    //2. dohvati sve workout idjeve za taj trening
    //3. dohvati te workoute

    func loadWorkoutsForTraining(forTraining trainingId:Int32)->[Workout]{
        
    var workouts = [Workout]()
    var training = [Training]()
    var workoutIdsInTraining = [Int32]()
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate?.persistentContainer.viewContext
        
        do{
            let fetchRequest : NSFetchRequest<Training> = Training.fetchRequest()
           // fetchRequest.predicate = NSPredicate(format: "id == %@", trainingId)
            let result = try managedContext?.fetch(fetchRequest)
            print("loaded core data")
            for wrkt in result! {
                print("\n ID - \(wrkt.id)")
                workoutIdsInTraining.append(wrkt.id)
            }
            //  self.lastID = (restaurants.last?.id)!
            workouts = loadWorkoutsForIds(forWorkoutIds: workoutIdsInTraining)
            
            return workouts
    
            
        }
        catch {
            fatalError("Error while trying to get core data")
        }
    
        return workouts
    }
    
    //fetch all workouts with ids
    
    func loadWorkoutsForIds(forWorkoutIds workoutIds: [Int32]) -> [Workout]{
    
        var workouts = [Workout]()
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate?.persistentContainer.viewContext
        
        do{
            let fetchRequest: NSFetchRequest<Workout> = Workout.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id IN %@", workoutIds)
            let result = try managedContext?.fetch(fetchRequest)
            for r in result!{
                print("\n R result - \(r.name!)!")
                
                workouts.append(r)
                
            }
            
            for wrkt in workouts{
                print("From workouts \(wrkt.name!)")
            }
            
        }
        
        catch {
            fatalError("Error while trying to fetch workouts in a training")
        
        }
        
        
        
        return workouts
    }
    

    
//    func addPhotoToRestaurant(markerID: Int32, photoAddress:String){
//    
//        let appDelegate = UIApplication.shared.delegate as? AppDelegate
//        
//        let managedContext = appDelegate?.persistentContainer.viewContext
//        
//        let fetchRequest : NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "id = %d", markerID)
//        
//        do{
//          
//            let result = try managedContext?.fetch(fetchRequest)
//            
//            for res in result! {
//                res.setValue(photoAddress, forKey: "photo")
//            }
//           
//        }
//        catch {
//            fatalError("Error while trying to get core data")
//        }
//        do{
//            try managedContext?.save()
//            
//        }catch let error as NSError{
//            print("Can't save due to \(error)")
//        }
//
//    }
    
//    func editInfo(markerID: Int32, name:String, address:String){
//        
//        let appDelegate = UIApplication.shared.delegate as? AppDelegate
//        
//        let managedContext = appDelegate?.persistentContainer.viewContext
//        
//        let fetchRequest : NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "id = %d", markerID)
//        
//        do{
//            
//            let result = try managedContext?.fetch(fetchRequest)
//            
//            for res in result! {
//                res.setValue(name, forKey: "name")
//                res.setValue(address, forKey: "address")
//            }
//            
//        }
//        catch {
//            fatalError("Error while trying to get core data")
//        }
//        do{
//            try managedContext?.save()
//            
//        }catch let error as NSError{
//            print("Can't save due to \(error)")
//        }
//        
//    }


}
