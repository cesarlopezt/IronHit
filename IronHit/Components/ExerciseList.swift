//
//  ExerciseList.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/21/23.
//

import SwiftUI

struct ExerciseList: View {
    @FetchRequest var exercises: FetchedResults<Exercise>
    
    var body: some View {
        ForEach(exercises) { exercise in
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
    
    init(contains name: String, with tags: Set<Tag>) {
        let predicate: NSPredicate?
        
        let tagNames = tags.map({ $0.name ?? "" })
        let nameIsEmpty = name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let tagsIsEmpty = tagNames.isEmpty
        if !nameIsEmpty && !tagsIsEmpty {
            predicate = NSPredicate(format: "name CONTAINS[c] %@ AND ANY tags.id IN %@", name, tagNames)
        } else if !nameIsEmpty {
            predicate = NSPredicate(format: "name CONTAINS[c] %@", name)
        } else if !tagsIsEmpty {
            predicate = NSPredicate(format: "ANY tags.name IN %@", tagNames)
        } else {
            predicate = nil
        }
        
        _exercises = FetchRequest<Exercise>(
            sortDescriptors: [SortDescriptor(\.name)],
            predicate: predicate
        )
    }
}

struct ExerciseList_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseList(contains: "", with: [])
    }
}
