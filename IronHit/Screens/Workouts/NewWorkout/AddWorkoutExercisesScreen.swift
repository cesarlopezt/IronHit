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
//    @Published var workoutExercises: [ExerciseRepsScheme] = []
    var body: some View {
        Form {
            Section {
                ForEach(Array(viewModel.workoutExercises.enumerated()), id: \.element) { index, ex in
                    HStack {
                        Text(ex.exercise.wrappedName)
                        
                        // TODO: Fix keyboard here
                        TextField("Hi", value: $viewModel.workoutExercises[index].reps, format: .number)
                            .keyboardType(.numberPad)
                    }
                }
                .onMove { source, destination in
                    viewModel.workoutExercises.move(fromOffsets: source, toOffset: destination)
                }
            }
        }
        .navigationTitle("Add the Reps. Scheme")
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
