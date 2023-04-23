//
//  ExerciseList.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/21/23.
//

import SwiftUI

struct ExerciseList<RowContent: View>: View {
    @FetchRequest var exercises: FetchedResults<Exercise>
    
    @ViewBuilder var rowContent: (Exercise) -> RowContent
    
    var body: some View {
        ForEach(exercises) { exercise in
            rowContent(exercise)
        }
    }
    
    init(contains name: String, with tags: Set<Tag>, @ViewBuilder rowContent: @escaping (Exercise) -> RowContent) {
        let predicate: NSPredicate
        
        let tagNames = tags.map({ $0.name ?? "" })
        let nameIsEmpty = name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let tagsIsEmpty = tagNames.isEmpty
        if !nameIsEmpty && !tagsIsEmpty {
            predicate = NSPredicate(format: "isShown == true AND name CONTAINS[c] %@ AND ANY tags.id IN %@", name, tagNames)
        } else if !nameIsEmpty {
            predicate = NSPredicate(format: "isShown == true AND name CONTAINS[c] %@", name)
        } else if !tagsIsEmpty {
            predicate = NSPredicate(format: "isShown == true AND ANY tags.name IN %@", tagNames)
        } else {
            predicate = NSPredicate(format: "isShown == true")
        }
        
        _exercises = FetchRequest<Exercise>(
            sortDescriptors: [SortDescriptor(\.name)],
            predicate: predicate
        )
        
        self.rowContent = rowContent
    }
}

struct ExerciseList_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseList(contains: "", with: []) {
            Text($0.wrappedName)
        }
    }
}
