//
//  AddWorkoutExercisesScreen.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/14/23.
//

import SwiftUI

/// Screen that allows the user to organize the workout's exercises
/// and set the number of sets and reps of each one, also allowing the
/// user to add more exercises.
struct AddWorkoutExercisesScreen: View {
    @ObservedObject var addWorkoutService: AddWorkoutService
    
    @State private var showingSelectExercises = false

    var body: some View {
        Form {
            Section {
                if (addWorkoutService.workoutExercises.isEmpty) {
                    Text("Let's add the exercises for this workout.")
                } else {
                    Grid(alignment: .leading) {
                        GridRow {
                            Text("")
                            Text("Reps")
                            Text("Sets")
                            Text("")
                        }
                        ForEach(Array(addWorkoutService.workoutExercises.enumerated()), id: \.offset) { index, workoutExercise in
                            GridRow {
                                Text(workoutExercise.wrappedExerciseName)
                                TextField("Reps", value: $addWorkoutService.workoutExercises[index].reps, format: .number)
                                    .keyboardType(.numberPad)
                                    .textFieldStyle(.roundedBorder)
                                TextField("Sets", value: $addWorkoutService.workoutExercises[index].sets, format: .number)
                                    .keyboardType(.numberPad)
                                    .textFieldStyle(.roundedBorder)
                                Button(role: .destructive) {
                                    addWorkoutService.removeWorkoutExercise(at: index)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                        .labelStyle(.iconOnly)
                                }
                                .buttonStyle(.borderless)
                            }
                        }
                    }
                }
            }
            Button("Add exercises") {
                showingSelectExercises = true
            }
        }
        .navigationTitle("Workout exercises")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    CreateWorkoutScreen(addWorkoutService: addWorkoutService)
                } label: {
                    Text("Next")
                }
                .disabled(addWorkoutService.workoutExercises.isEmpty)
            }
        }
        .sheet(isPresented: $showingSelectExercises) {
            SelectWorkoutExercisesScreen(addWorkoutService: addWorkoutService)
        }
    }
}
