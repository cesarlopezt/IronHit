//
//  AddExerciseScreen.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/12/23.
//

import SwiftUI

struct AddExerciseScreen: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var showingAddTags = false
    @State private var name = ""
    @State private var description = ""
    @State private var tags: Set<Tag> = []
    @FocusState private var descriptionFocused: Bool

    var exerciseToUpdate: Exercise?
    
    var isSaveDisabled: Bool {
        name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Section {
                    TextEditor(text: $description)
                        .frame(height: 200)
                        .focused($descriptionFocused)
                } header: {
                    Text("Description")
                }

                Button {
                    showingAddTags.toggle()
                } label: {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Tags")
                            Spacer()
                            // TODO: This doesn't work well on RTL languages
                            Image(systemName: "chevron.right")
                        }
                        // TODO: I don't think I should convert this on each render
                        TagsList(tags: Array(tags))
                    }
                    .foregroundColor(.primary)
                }
            }
            .navigationTitle(exerciseToUpdate == nil ? "New exercise" : "Edit exercise")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(exerciseToUpdate == nil ? "Add" : "Save") {
                        exerciseToUpdate == nil ? saveExercise() : editExercise()
                    }
                    .disabled(isSaveDisabled)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("OK") {
                        descriptionFocused = false
                    }
                }
            }
            .sheet(isPresented: $showingAddTags) {
                AddTagsScreen(selectedTags: $tags)
            }
        }
    }
    
    func saveExercise() {
        let exercise = Exercise(context: moc)
        exercise.id = UUID()
        exercise.name = name
        exercise.desc = description
        exercise.tags = NSSet(set: tags)
        
        try? moc.save()
        dismiss()
    }
    
    func editExercise() {
        guard let exerciseToUpdate else { return }
        exerciseToUpdate.name = name
        exerciseToUpdate.desc = description
        exerciseToUpdate.tags = NSSet(set: tags)
        
        try? moc.save()
        dismiss()
    }
    
    init(exerciseToUpdate: Exercise? = nil) {
        self.exerciseToUpdate = exerciseToUpdate
        guard let exerciseToUpdate else { return }
        self._name = State(initialValue: exerciseToUpdate.name ?? "")
        self._description = State(initialValue: exerciseToUpdate.desc ?? "")
        self._tags = State(initialValue: Set(exerciseToUpdate.tagArray))
    }
}

struct AddExerciseScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddExerciseScreen()
    }
}
