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
        
        /// Function that sets workoutExercises.
        /// * When empty adds all the selected exercises
        /// * Filters out deselected items
        /// * Adds new to list of workoutExercises
        func updateWorkoutExercises() {
            if workoutExercises.isEmpty {
                workoutExercises = exercises.map({ newRepScheme(exercise: $0) })
                return
            }
            
            let prevSelectedExercises = Set(workoutExercises.map({ $0.exercise }))

            // Filter out deselected items
            let deselectedExercises = prevSelectedExercises.subtracting(exercises)
            workoutExercises = workoutExercises.filter { repScheme in
                !deselectedExercises.contains(repScheme.exercise)
            }
            
            // Add new Exercises
            let newExercises = exercises.subtracting(prevSelectedExercises)
            let newRepSchemes = newExercises.map({ newRepScheme(exercise: $0) })
            workoutExercises.append(contentsOf: newRepSchemes)
        }
        
        private func newRepScheme(exercise: Exercise) -> ExerciseRepsScheme {
            return ExerciseRepsScheme(exercise: exercise, reps: 0, sets: 0)
        }
    }
}
