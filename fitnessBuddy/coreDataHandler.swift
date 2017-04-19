//
//  coreDataHandler.swift
//  restauranter
//
//  Created by Darko Dujmovic on 03/04/2017.
//  Copyright © 2017 Darko Dujmovic. All rights reserved.
//

import UIKit
import CoreData


class coreDataHandler: NSObject {
    
    
   // var lastID:Int32 = 0

    func saveWorkout (workout: workoutModel, completion:()->()){
       
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
//        /   let workoutForSaving = workoutModel(wrktDuration: 12, wrktReps: 2, wrktSets: 2, wrktName: self.workoutName.text!, zeroIsRepsOneIsSets: true, wrktId: lstId)
        
        
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
        
        }catch let error as NSError{
            print("Can't save due to \(error)")
        }
    }
    
    func loadCoreData()->[Workout]{
        
        var workouts = [Workout]()
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let managedContext = appDelegate?.persistentContainer.viewContext
        
        do{
            let fetchRequest : NSFetchRequest<Workout> = Workout.fetchRequest()
            
            let result = try managedContext?.fetch(fetchRequest)
            print("Dildo")
            for wrkt in result! {
                workouts.append(wrkt)
            }
          //  self.lastID = (restaurants.last?.id)!
            
            for wrkt in workouts{
                print("\n core data load workouts are \(wrkt.name!) \n")
            }
            
            return workouts
            
        }
        catch {
            fatalError("Error while trying to get core data")
        }
        print("Restaurants = \(workouts[0])")
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
