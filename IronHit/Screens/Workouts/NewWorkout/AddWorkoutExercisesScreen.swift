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
    @ObservedObject var viewModel: AddWorkoutScreen.ViewModel

    var body: some View {
        Form {
            Section {
                Grid {
                    GridRow {
                        Text("")
                        Text("Reps")
                        Text("Sets")
                    }
                    ForEach(Array(viewModel.workoutExercises.enumerated()), id: \.offset) { index, ex in
                        GridRow {
                            Text(ex.exercise.wrappedName)
                            TextField("Reps", value: $viewModel.workoutExercises[index].reps, format: .number)
                                .keyboardType(.numberPad)
                                .textFieldStyle(.roundedBorder)
                            TextField("Sets", value: $viewModel.workoutExercises[index].sets, format: .number)
                                .keyboardType(.numberPad)
                                .textFieldStyle(.roundedBorder)
                        }
                    }
                }
            }
        }
        .navigationTitle("Rep Scheme")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    CreateWorkoutScreen(viewModel: viewModel)
                } label: {
                    Text("Next")
                }
            }
        }
        .onAppear {
            viewModel.updateWorkoutExercises()
        }
    }
}
