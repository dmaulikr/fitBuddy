//
//  trainingModel.swift
//  fitnessBuddy
//
//  Created by Darko Dujmovic on 23/04/2017.
//  Copyright © 2017 Darko Dujmovic. All rights reserved.
//

import UIKit

class trainingModel: NSObject {
    var duration:Double
    var durSet:Bool
    var name: String
    var reps: Int32
    var sets: Int32
    var trainingId: Int32
    var wrktId: Int32
    
    init(trainingDuration: Double, durSet: Bool, name:String, reps:Int32, sets:Int32, trainingId:Int32, workoutID:Int32){
        self.duration = trainingDuration
        self.durSet = durSet
        self.name = name
        self.reps = reps
        self.sets = sets
        self.trainingId = trainingId
        self.wrktId = workoutID
    
    }
    
}
