//
//  WorkoutList.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/21/23.
//

import SwiftUI

struct WorkoutList<RowContent: View, ActiveWorkout: View>: View {
    @FetchRequest var workouts: FetchedResults<Workout>

    @ViewBuilder var rowContent: (Workout) -> RowContent
    @ViewBuilder var activeWorkout: () -> ActiveWorkout
    @Binding var showingAddWorkout: Bool
    var usingFilters: Bool
    
    var body: some View {
        if workouts.count == 0 {
            if usingFilters {
                List {
                    Text("This is a little empty, add some workouts.")
                }
            } else {
                Button {
                    showingAddWorkout.toggle()
                } label: {
                    Label("Add your first workout", systemImage: "plus")
                }
            }
        }
        else {
            List {
                activeWorkout()
                ForEach(workouts) { workout in
                    rowContent(workout)
                }
            }
        }
    }
    
    init(
        contains name: String,
        showingAddWorkout: Binding<Bool>,
        usingFilters: Bool,
        rowContent: @escaping (Workout) -> RowContent,
        activeWorkout: @escaping () -> ActiveWorkout
    ) {
        self.usingFilters = usingFilters
        self._showingAddWorkout = showingAddWorkout
        
        var predicates: [NSPredicate] = [NSPredicate(format: "isShown == true")]
        let nameIsEmpty = name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        if !nameIsEmpty {
            predicates.append(NSPredicate(format: "name CONTAINS[c] %@", name))
        }

        _workouts = FetchRequest<Workout>(
            sortDescriptors: [SortDescriptor(\.name)],
            predicate: NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        )
        
        self.rowContent = rowContent
        self.activeWorkout = activeWorkout
    }
}

struct WorkoutList_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutList(contains: "", showingAddWorkout: .constant(false), usingFilters: true) {
            Text($0.wrappedName)
        } activeWorkout: {
            Text("Active")
        }
    }
}
