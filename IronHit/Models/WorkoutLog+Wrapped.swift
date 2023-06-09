//
//  WorkoutLog+Wrapped.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/18/23.
//

import Foundation

extension WorkoutLog {
    public var wrappedWorkoutName: String {
        workout?.name ?? ""
    }
    
    public var exerciseLogArray: [ExerciseLog] {
        let set = exerciseLogs as? Set<ExerciseLog> ?? []
        
        return set.sorted {
            $0.workoutExercise?.order ?? 0 < $1.workoutExercise?.order ?? 0
        }
    }
    
    @objc
    public var dateString: String {
        guard let date = self.date else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}
