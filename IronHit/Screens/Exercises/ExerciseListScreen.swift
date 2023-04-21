//
//  ExerciseList.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/12/23.
//

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
                List {
                    if (showingTagFilters) {
                        FilterByTagsSection(selectedTags: $selectedTags)
                    }
                    ExerciseList(contains: queryString, with: selectedTags)
                }
                Button("Add mock data") {
                    let armTag = Tag(context: moc)
                    armTag.id = UUID()
                    armTag.name = "Arms"
                    
                    let bicepTag = Tag(context: moc)
                    bicepTag.id = UUID()
                    bicepTag.name = "Biceps"
                    
                    let tricepTag = Tag(context: moc)
                    tricepTag.id = UUID()
                    tricepTag.name = "Triceps"
                    
                    let backTag = Tag(context: moc)
                    backTag.id = UUID()
                    backTag.name = "Back"
                    
                    let exercise1 = Exercise(context: moc)
                    exercise1.id = UUID()
                    exercise1.name = "Biceps Curl"
                    exercise1.desc = "Test Descr"
                    exercise1.tags = NSSet(array: [armTag, bicepTag])
                    
                    let exercise2 = Exercise(context: moc)
                    exercise2.id = UUID()
                    exercise2.name = "Triceps Extension"
                    exercise2.desc = "Test Descr"
                    exercise2.tags = NSSet(array: [armTag, tricepTag])
                    
                    let exercise3 = Exercise(context: moc)
                    exercise3.id = UUID()
                    exercise3.name = "Pull Ups"
                    exercise3.desc = "Test Descr"
                    exercise3.tags = NSSet(array: [backTag])
                    
                    let exercise4 = Exercise(context: moc)
                    exercise4.id = UUID()
                    exercise4.name = "Chin Ups"
                    exercise4.desc = "Test Descr"
                    exercise4.tags = NSSet(array: [armTag, bicepTag])
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
