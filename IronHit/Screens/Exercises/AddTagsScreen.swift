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
    @State private var tagToDelete: Tag? = nil
    @State private var showingDelete = false
    @Binding var selectedTags: Set<Tag>
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        TextField("Add new tag", text: $name)
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
                if (tags.isEmpty) {
                    Text("Add your first tag.")
                } else {
                    ForEach(tags) { tag in
                        HStack {
                            Button { toggleTag(tag) } label: {
                                HStack {
                                    Image(systemName: selectedTags.contains(tag) ? "checkmark.circle.fill" : "circle")
                                    Text(tag.wrappedName)
                                }
                                .foregroundColor(.primary)
                            }
                            .buttonStyle(.plain)
                            Spacer()
                            Button(role: .destructive) {
                                tagToDelete = tag
                                showingDelete = true
                            } label: {
                                Label("Delete tag", systemImage: "trash")
                                    .labelStyle(.iconOnly)
                            }
                            .buttonStyle(.borderless)
                        }
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
            .alert("Delete Tag", isPresented: $showingDelete, actions: {
                Button("Delete", role: .destructive) { deleteTag(tagToDelete) }
            }, message: {
                Text("Are you sure you want to delete \(tagToDelete?.wrappedName ?? "")?")
            })
        }
    }
    
    func toggleTag(_ tag: Tag) {
        if (selectedTags.contains(tag)) {
            selectedTags.remove(tag)
        } else {
            selectedTags.insert(tag)
        }
    }
    
    func deleteTag(_ tag: Tag?) {
        if let tag {
            moc.delete(tag)
            try? moc.save()
        }
    }
    
    func addTag() {
        if (!name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) {
            let tag = Tag(context: moc)
            tag.id = UUID()
            tag.name = name
            
            name = ""
            
            try? moc.save()
        }
    }
}

//struct AddTagsScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTagsScreen()
//    }
//}
