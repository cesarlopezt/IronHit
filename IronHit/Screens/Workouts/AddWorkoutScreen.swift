//
//  AddWorkoutScreen.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/13/23.
//

import SwiftUI

struct AddWorkoutScreen: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var showingSelectExercises = false
    @State private var name = ""
    @State private var description = ""
    @State private var exercises: Set<Exercise> = []
    
    var isSaveDisabled: Bool {
        name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && exercises.isEmpty
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Section {
                    TextEditor(text: $description)
                        .frame(height: 200)
                } header: {
                    Text("Description")
                }
                
                Section {
                    ForEach(["hi", "bye", "heabe", "efaebearw"], id: \.self) {
                        Text($0)
                    }
                } header: {
                    Text("Exercises")
                }

                Button {
                    showingSelectExercises.toggle()
                } label: {
                    Text(exercises.isEmpty ? "Add Exercises" : "Modify Exercises")
                }
            }
            .navigationTitle("New workout")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        saveWorkout()
                    }
                    .disabled(isSaveDisabled)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $showingSelectExercises) {
//                AddTagsScreen(selectedTags: $tags)
            }
        }
    }
    
    func saveWorkout() {
        let workout = Workout(context: moc)
        workout.id = UUID()
        workout.name = name
        workout.desc = description
//        workout.tags = NSSet(set: tags)
        
        dismiss()
    }
}

struct AddWorkoutScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddWorkoutScreen()
    }
}
