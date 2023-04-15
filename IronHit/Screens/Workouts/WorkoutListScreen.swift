//
//  WorkoutListScreen.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/13/23.
//

import SwiftUI

struct WorkoutListScreen: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var workouts: FetchedResults<Workout>
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(workouts) { workout in
                        VStack(alignment: .leading, spacing: 5) {
                            Text(workout.wrappedName)
                        }
                    }
                }
            }
            .navigationTitle("Workouts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AddWorkoutScreen()
                    } label: {
                        Label("Add Workout", systemImage: "plus")
                    }
                }
            }
        }
    }
}

struct WorkoutListScreen_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutListScreen()
    }
}
