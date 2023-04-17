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
    @ObservedObject var viewModel: AddWorkoutScreen.ViewModel
    @Binding var showingAddWorkout: Bool
    
    var body: some View {
        Form {
            TextField("Name", text: $viewModel.name)
            
            Section {
                TextEditor(text: $viewModel.description)
                    .frame(height: 200)
            } header: {
                Text("Description")
            }
            
            Section {
                ForEach(viewModel.workoutExercises) {
                    RepsSchemeCell(exerciseName: $0.exercise.wrappedName, reps: $0.reps, sets: $0.sets, showReorder: true)
                }
                .onMove { source, destination in
                    viewModel.workoutExercises.move(fromOffsets: source, toOffset: destination)
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
                .disabled(viewModel.isSaveDisabled)
            }
        }
    }
    
    func saveWorkout() {
        let workout = Workout(context: moc)
        workout.id = UUID()
        workout.name = viewModel.name
        workout.desc = viewModel.description

        for (index, repScheme) in Array(viewModel.workoutExercises.enumerated()) {
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
