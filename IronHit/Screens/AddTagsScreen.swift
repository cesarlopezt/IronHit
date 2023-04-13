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
    @State private var selectedTags: Set<Tag> = []
    
    var selectTags: (Set<Tag>) -> Void
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Tag name", text: $name)
                        .submitLabel(.done)
                        .onSubmit {
                            addTag()
                        }
                }
                ForEach(tags, id: \.id) { tag in
                    Button {
                        if (selectedTags.contains(tag)) {
                            selectedTags.remove(tag)
                        } else {
                            selectedTags.insert(tag)
                        }
                    } label: {
                        HStack {
                            Text(tag.wrappedName)
                            Spacer()
                            if ( selectedTags.contains(tag)) {
                                Image(systemName:"checkmark")
                            }
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
                        selectTags(selectedTags)
                        dismiss()
                        
                    }
                    .disabled(selectedTags.isEmpty)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
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
