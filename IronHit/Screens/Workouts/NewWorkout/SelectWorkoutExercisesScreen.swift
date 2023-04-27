//
//  SelectWorkoutExercisesScreen.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/14/23.
//

import SwiftUI

struct SelectWorkoutExercisesScreen: View {
    @Environment(\.dismiss) var dismiss
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var exercises: FetchedResults<Exercise>
    
    @ObservedObject var addWorkoutService: AddWorkoutService
    @State private var searchQuery = ""
    @State private var selectedTags: Set<Tag> = []
    @State private var selectedExercises: Set<Exercise> =  []

    var body: some View {
        NavigationView {
            // TODO: I Could probably use the selection param in lists and set EditMode to true
            ExerciseList(
                contains: searchQuery,
                with: $selectedTags,
                showingTagFilters: .constant(true),
                showingAddExercise: .constant(false),
                usingFilters: true
            ) { exercise in
                Button {
                    if (selectedExercises.contains(exercise)) {
                        selectedExercises.remove(exercise)
                    } else {
                        selectedExercises.insert(exercise)
                    }
                } label: {
                    HStack {
                        Image(systemName: selectedExercises.contains(exercise) ? "checkmark.circle.fill" : "circle")
                        Text(exercise.wrappedName)
                    }
                    .foregroundColor(.primary)
                }
            }
            .navigationTitle("Select exercises")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        addWorkoutService.addExercises(exercises: selectedExercises)
                        dismiss()
                    }
                    .disabled(selectedExercises.isEmpty)
                }
            }
            .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always))
        }
    }
}
