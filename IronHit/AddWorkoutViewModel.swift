//
//  File.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/14/23.
//

import CoreData
import Foundation

extension AddWorkoutScreen {
    @MainActor class ViewModel: ObservableObject {
        @Published var exercises: Set<Exercise> = []
        @Published var workoutExercises: [ExerciseRepsScheme] = []
        @Published var name = ""
        @Published var description = ""
        
        var isSaveDisabled: Bool {
            name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && workoutExercises.isEmpty
        }
        
        func updateWorkoutExercises() {
            workoutExercises = exercises.map({ exercise in
                ExerciseRepsScheme(exercise: exercise, reps: 0, sets: 0)
            })
        }
    }
}
