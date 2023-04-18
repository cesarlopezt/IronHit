//
//  Workout+Wrapped.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/13/23.
//

import Foundation

extension Workout {
    public var wrappedName: String {
        name ?? ""
    }
    
    public var exerciseEntriesArray: [WorkoutExercise] {
        let set = exerciseEntries as? Set<WorkoutExercise> ?? []
        
        return set.sorted {
            $0.order < $1.order
        }
    }
}
