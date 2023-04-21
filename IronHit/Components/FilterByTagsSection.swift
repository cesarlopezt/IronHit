//
//  FilterByTags.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/21/23.
//

import SwiftUI

struct FilterByTagsSection: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var tags: FetchedResults<Tag>
    @Binding var selectedTags: Set<Tag>
    
    var body: some View {
        Section {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(tags) { tag in
                        Text(tag.wrappedName)
                            .font(.caption)
                            .padding(5)
                            .background(selectedTags.contains(tag) ? .blue.opacity(0.3) : .secondary.opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .onTapGesture {
                                if (selectedTags.contains(tag)) {
                                    selectedTags.remove(tag)
                                } else {
                                    selectedTags.insert(tag)
                                }
                            }
                    }
                }
                .padding(.vertical, 5)
            }
        } header: {
            Text("Tags")
        }
    }
}

struct FilterByTagsSection_Previews: PreviewProvider {
    static var previews: some View {
        FilterByTagsSection(selectedTags: .constant([]))
    }
}
