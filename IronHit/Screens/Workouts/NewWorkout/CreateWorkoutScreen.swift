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
            Text(exerciseRepsScheme.exercise.wrappedName)
            Text(exerciseRepsScheme.reps, format: .number)
            Text(exerciseRepsScheme.sets, format: .number)
        }
    }
}

struct CreateWorkoutScreen: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var viewModel: AddWorkoutScreen.ViewModel
    
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
            } header: {
                Text("Exercises")
            }

            Button {
            } label: {
                Text(viewModel.workoutExercises.isEmpty ? "Add Exercises" : "Modify Exercises")
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
    }
}
