//
//  workoutModel.swift
//  fitnessBuddy
//
//  Created by Darko Dujmovic on 17/04/2017.
//  Copyright © 2017 Darko Dujmovic. All rights reserved.
//

import UIKit

class workoutModel: NSObject {
    let defDur: Double
    let defReps: Int32
    let defSets: Int32
    let name: String
    let repSet: Bool
    let wrktId:Int32
    
    init(wrktDuration:Double, wrktReps:Int32, wrktSets:Int32, wrktName:String, zeroIsRepsOneIsSets repsOrSets:Bool, wrktId:Int32){
        
        self.defDur = wrktDuration
        self.defReps=wrktReps
        self.defSets = wrktSets
        self.name = wrktName
        self.repSet = repsOrSets
        self.wrktId = wrktId
    }
    

}
