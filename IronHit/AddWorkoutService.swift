//
//  AddWorkoutService.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/14/23.
//

import CoreData
import Foundation

@MainActor class AddWorkoutService: ObservableObject {
    var moc: NSManagedObjectContext
    @Published var workoutExercises: [WorkoutExercise] = []
    @Published var name = ""
    @Published var description = ""
    @Published var workoutToEdit: Workout?
    
    var isSaveDisabled: Bool {
        name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && workoutExercises.isEmpty
    }
    
    func addExercises(exercises: Set<Exercise>) {
        let newWorkoutExercises = exercises.map({ newWorkoutExercise(exercise: $0) })
        workoutExercises.append(contentsOf: newWorkoutExercises)
    }
    
    func removeWorkoutExercise(at index: Int) {
        moc.delete(workoutExercises[index])
        workoutExercises.remove(at: index)
    }

    private func newWorkoutExercise(exercise: Exercise) -> WorkoutExercise {
        let workoutExercise = WorkoutExercise(context: moc)
        workoutExercise.exercise = exercise
        workoutExercise.id = UUID()
        workoutExercise.sets = 0
        workoutExercise.reps = 0
        return workoutExercise
    }
    
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
//    init(workoutToEdit: Workout? = nil) {
//        self.workoutToEdit = workoutToEdit
//        guard let workoutToEdit else { return }
//        name = workoutToEdit.wrappedName
//        description = workoutToEdit.desc ?? ""
//        exercises = Set(workoutToEdit.exerciseEntriesArray.compactMap({ $0.exercise }))
//        workoutExercises = workoutToEdit.exerciseEntriesArray.compactMap({ workoutExercise in
//            ExerciseRepsScheme(exercise: <#T##Exercise#>, reps: <#T##Int16#>, sets: <#T##Int16#>)
//        })
//    }
}
