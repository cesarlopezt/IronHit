//
//  WorkoutList.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/21/23.
//

import SwiftUI

struct WorkoutList<RowContent: View>: View {
    @FetchRequest var workouts: FetchedResults<Workout>

    @ViewBuilder var rowContent: (Workout) -> RowContent
    
    var body: some View {
        ForEach(workouts) { workout in
            rowContent(workout)
        }
    }
    
    init(contains name: String, rowContent: @escaping (Workout) -> RowContent) {
        var predicate: NSPredicate? = nil

        let nameIsEmpty = name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        if !nameIsEmpty {
            predicate = NSPredicate(format: "name CONTAINS[c] %@", name)
        }
        
        _workouts = FetchRequest<Workout>(
            sortDescriptors: [SortDescriptor(\.name)],
            predicate: predicate
        )
        
        self.rowContent = rowContent
    }
}

struct WorkoutList_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutList(contains: "") {
            Text($0.wrappedName)
        }
    }
}
