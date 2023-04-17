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
    @State private var showingAddWorkout = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(workouts) { workout in
                        NavigationLink(destination: WorkoutDetailScreen(workout: workout)) {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(workout.wrappedName)
                            }                            
                        }
                    }
                }
            }
            .navigationTitle("Workouts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    // TODO: Adapt to new iOS navigation API and fix this deprecation
                    NavigationLink(destination: AddWorkoutScreen(showingAddWorkout: $showingAddWorkout), isActive: $showingAddWorkout) {
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
