//
//  ExerciseList.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/12/23.
//

import CoreData
import SwiftUI

struct ExerciseListScreen: View {
    @Environment(\.managedObjectContext) var moc

    @State private var showingAddExercise = false
    @State private var showingTagFilters = false
    @State private var queryString = ""
    @State private var selectedTags: Set<Tag> = []
    
    var body: some View {
        NavigationView {
            VStack {
                ExerciseList(
                    contains: queryString,
                    with: $selectedTags,
                    showingTagFilters: $showingTagFilters,
                    showingAddExercise: $showingAddExercise,
                    usingFilters: !selectedTags.isEmpty || !queryString.isEmpty
                ) { exercise in
                    NavigationLink {
                        ExerciseDetailScreen(exercise: exercise)
                    } label: {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(exercise.wrappedName)
                            TagsList(tags: exercise.tagArray)
                        }
                    }
                }
            }
            .navigationTitle("Exercises")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button {
                            showingTagFilters.toggle()
                        } label: {
                            Label("Filter by tags", systemImage: showingTagFilters ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
                        }
                        Button {
                            showingAddExercise.toggle()
                        } label: {
                            Label("Add Exercise", systemImage: "plus")
                        }
                    }
                }
            }
            .sheet(isPresented: $showingAddExercise) {
                AddExerciseScreen()
            }
        }
        .searchable(text: $queryString) {}
    }
}

struct ExerciseListScreen_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseListScreen()
    }
}
