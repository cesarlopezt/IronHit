//
//  SelectWorkoutExercisesScreen.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/14/23.
//

import SwiftUI

struct SelectWorkoutExercisesScreen: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var exercises: FetchedResults<Exercise>
    
    @ObservedObject var addWorkoutService: AddWorkoutService
    @Binding var showingAddWorkout: Bool

    @State private var searchQuery = ""
    @State private var selectedTags: Set<Tag> = []

    var body: some View {
        // TODO: I Could probably use the selection param in lists and set EditMode to true
        ExerciseList(
            contains: searchQuery,
            with: $selectedTags,
            showingTagFilters: .constant(true),
            showingAddExercise: .constant(false),
            usingFilters: true
        ) { exercise in
            Button {
                if (addWorkoutService.exercises.contains(exercise)) {
                    addWorkoutService.exercises.remove(exercise)
                } else {
                    addWorkoutService.exercises.insert(exercise)
                }
            } label: {
                HStack {
                    Image(systemName: addWorkoutService.exercises.contains(exercise) ? "checkmark.circle.fill" : "circle")
                    Text(exercise.wrappedName)
                }
                .foregroundColor(.primary)
            }
        }
        .navigationTitle("Select exercises")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    AddWorkoutExercisesScreen(addWorkoutService: addWorkoutService, showingAddWorkout: $showingAddWorkout)
                } label: {
                    Text("Next")
                }
                .disabled(addWorkoutService.exercises.isEmpty)
            }
        }
        .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always))
    }
}
