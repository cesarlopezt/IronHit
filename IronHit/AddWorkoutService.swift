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
    
    func saveWorkout() {
        let workout: Workout
        
        if let workoutToEdit {
            workout = workoutToEdit
        } else {        
            workout = Workout(context: moc)
            workout.id = UUID()
        }
        workout.name = name
        workout.desc = description

        for (index, workoutExercise) in Array(workoutExercises.enumerated()) {
            workoutExercise.order = Int16(index)
            workoutExercise.workout = workout
        }
        try? moc.save()
    }
    
    init(moc: NSManagedObjectContext, workoutToEdit: Workout? = nil) {
        self.moc = moc
        
        guard let workoutToEdit else { return }
        self.workoutToEdit = workoutToEdit
        name = workoutToEdit.wrappedName
        description = workoutToEdit.desc ?? ""
        workoutExercises = workoutToEdit.exerciseEntriesArray
    }
}
