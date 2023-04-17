//
//  CreateWorkoutScreen.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/14/23.
//

import SwiftUI

struct ExerciseCell: View {
    var exerciseRepsScheme: ExerciseRepsScheme
    
    var body: some View {
        HStack {
            Image(systemName: "line.3.horizontal")
                .foregroundColor(.primary.opacity(0.2))
            Text(exerciseRepsScheme.exercise.wrappedName)
            Spacer()
            Text("\(exerciseRepsScheme.reps) x \(exerciseRepsScheme.sets)")
        }
    }
}

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
                    ExerciseCell(exerciseRepsScheme: $0)
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
            workoutExercise.sets = Int16(repScheme.sets)
            workoutExercise.sets = Int16(repScheme.sets)
            workoutExercise.order = Int16(index)
            workoutExercise.workout = workout
        }
        
        showingAddWorkout = false
    }
}
