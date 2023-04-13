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
    @State private var tags: [Tag] = []
    
    var isSaveDisabled: Bool {
        name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Section {
                    ZStack(alignment: .leading) {
                        TextEditor(text: $description)
                            .frame(height: 200)
                    }
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
                        TagsList(tags: tags)
                    }
                    .foregroundColor(.primary)
                }
            }
            .navigationTitle("New exercise")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        saveExercise()
                    }
                    .disabled(isSaveDisabled)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $showingAddTags) {
                AddTagsScreen(selectTags: selectTags)
            }
        }
    }
    
    func saveExercise() {
        let exercise = Exercise(context: moc)
        exercise.id = UUID()
        exercise.name = name
        exercise.desc = description
        exercise.tags = NSSet(array: tags)
        
        dismiss()
    }
    
    func selectTags(selectedTags: Set<Tag>) {
        tags = Array(selectedTags)
    }
}

struct AddExerciseScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddExerciseScreen()
    }
}
