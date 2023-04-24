//
//  ExerciseList.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/21/23.
//

import CoreData
import SwiftUI

struct ExerciseList<RowContent: View>: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest var exercises: FetchedResults<Exercise>
    
    @ViewBuilder var rowContent: (Exercise) -> RowContent
    @Binding var showingTagFilters: Bool
    @Binding var showingAddExercise: Bool
    @Binding var selectedTags: Set<Tag>
    var usingFilters: Bool
    
    var body: some View {
        if exercises.count == 0 {
            if usingFilters {
                List {
                    Text("This is a little empty, add some exercises.")
                }
            } else {
                Button {
                    showingAddExercise.toggle()
                } label: {
                    Label("Add your first exercise", systemImage: "plus")
                }
            }
        }
        else {
            List {
                if (showingTagFilters) {
                    FilterByTagsSection(selectedTags: $selectedTags)
                }
                ForEach(exercises) { exercise in
                    rowContent(exercise)
                }
            }
        }
    }
    
    init(contains name: String,
         with tags: Binding<Set<Tag>>,
         showingTagFilters: Binding<Bool>,
         showingAddExercise: Binding<Bool>,
         usingFilters: Bool,
         @ViewBuilder rowContent: @escaping (Exercise) -> RowContent
    ) {
        self.usingFilters = usingFilters
        self._selectedTags = tags
        self._showingTagFilters = showingTagFilters
        self._showingAddExercise = showingAddExercise

        var predicates: [NSPredicate] = [NSPredicate(format: "isShown == true")]
        let tagNames = tags.wrappedValue.map({ $0.name ?? "" })
        let nameIsEmpty = name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let tagsIsEmpty = tagNames.isEmpty
        if !nameIsEmpty {
            predicates.append(NSPredicate(format: "name CONTAINS[c] %@", name))
        }
        if !tagsIsEmpty {
            predicates.append(NSPredicate(format: "ANY tags.name IN %@", tagNames))
        }
        
        _exercises = FetchRequest<Exercise>(
            sortDescriptors: [SortDescriptor(\.name)],
            predicate: NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        )
        
        self.rowContent = rowContent
    }
}

struct ExerciseList_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseList(contains: "", with: .constant([]), showingTagFilters: .constant(true), showingAddExercise: .constant(true), usingFilters: true) {
            Text($0.wrappedName)
        }
    }
}
