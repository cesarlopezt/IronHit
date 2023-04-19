//
//  CreateWorkoutScreen.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/14/23.
//

import SwiftUI


struct CreateWorkoutScreen: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var addWorkoutService: AddWorkoutService
    @Binding var showingAddWorkout: Bool
    
    var body: some View {
        Form {
            TextField("Name", text: $addWorkoutService.name)
            
            Section {
                TextEditor(text: $addWorkoutService.description)
                    .frame(height: 200)
            } header: {
                Text("Description")
            }
            
            Section {
                ForEach(addWorkoutService.workoutExercises) {
                    RepsSchemeCell(exerciseName: $0.exercise.wrappedName, reps: $0.reps, sets: $0.sets, showReorder: true)
                }
                .onMove { source, destination in
                    addWorkoutService.workoutExercises.move(fromOffsets: source, toOffset: destination)
                }
            }
        header: {
                Text("Exercises")
            }
        }
        .navigationTitle("New workout")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    saveWorkout()
                }
                .disabled(addWorkoutService.isSaveDisabled)
            }
        }
    }
    
    func saveWorkout() {
        let workout = Workout(context: moc)
        workout.id = UUID()
        workout.name = addWorkoutService.name
        workout.desc = addWorkoutService.description

        for (index, repScheme) in Array(addWorkoutService.workoutExercises.enumerated()) {
            let workoutExercise = WorkoutExercise(context: moc)
            workoutExercise.id = UUID()
            workoutExercise.exercise = repScheme.exercise
            workoutExercise.reps = repScheme.reps
            workoutExercise.sets = repScheme.sets
            workoutExercise.order = Int16(index)
            workoutExercise.workout = workout
        }
        try? moc.save()
        showingAddWorkout = false
    }
}
