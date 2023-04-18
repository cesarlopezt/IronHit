//
//  AddTagsScreen.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/12/23.
//

import SwiftUI

struct AddTagsScreen: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var tags: FetchedResults<Tag>
    
    @State private var name = ""
    @Binding var selectedTags: Set<Tag>
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        TextField("Add tag name", text: $name)
                            .submitLabel(.done)
                            .onSubmit {
                                addTag()
                            }
                        Button("Add") {
                            addTag()
                        }
                        .buttonStyle(.borderless)
                    }
                }
                ForEach(tags) { tag in
                    Button {
                        if (selectedTags.contains(tag)) {
                            selectedTags.remove(tag)
                        } else {
                            selectedTags.insert(tag)
                        }
                    } label: {
                        HStack {
                            Image(systemName: selectedTags.contains(tag) ? "checkmark.circle.fill" : "circle")
                            Text(tag.wrappedName)
                        }
                        .foregroundColor(.primary)
                    }
                }
            }
            .navigationTitle("Tags")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()   
                    }
                }
            }
        }
    }
    
    func addTag() {
        if (!name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) {
            let tag = Tag(context: moc)
            tag.id = UUID()
            tag.name = name
            
            name = ""
        }
    }
}

//struct AddTagsScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTagsScreen()
//    }
//}
