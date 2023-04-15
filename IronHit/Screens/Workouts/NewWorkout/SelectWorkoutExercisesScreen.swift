//
//  SelectWorkoutExercisesScreen.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/14/23.
//

import SwiftUI

struct SelectWorkoutExercisesScreen: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var exercises: FetchedResults<Exercise>
    
    @ObservedObject var viewModel: AddWorkoutScreen.ViewModel
    
    var body: some View {
        List {
            ForEach(exercises) { exercise in
                Button {
                    if (viewModel.exercises.contains(exercise)) {
                        viewModel.exercises.remove(exercise)
                    } else {
                        viewModel.exercises.insert(exercise)
                    }
                } label: {
                    HStack {
                        Image(systemName: viewModel.exercises.contains(exercise) ? "checkmark.circle.fill" : "circle")
                        Text(exercise.wrappedName)
                    }
                    .foregroundColor(.primary)
                }
            }
        }
        .navigationTitle("Select exercises")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    AddWorkoutExercisesScreen(viewModel: viewModel)
                } label: {
                    Text("Next")
                }
            }
        }
    }
}
