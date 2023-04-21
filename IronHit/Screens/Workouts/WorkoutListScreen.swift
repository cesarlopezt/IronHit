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
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "isCompleted == false")) var workoutLogs: FetchedResults<WorkoutLog>
    @State private var showingAddWorkout = false
    @State private var showingActiveWorkout = false
    @State private var queryString = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    if (!workoutLogs.isEmpty) {
                        Section {
                            ForEach(workoutLogs) { workoutLog in
                                NavigationLink {
                                    ActiveWorkoutScreen(workoutLog: workoutLog, showingActiveWorkout: .constant(true))
                                } label: {
                                    Text(workoutLog.workout?.wrappedName ?? "")
                                }
                            }
                        } header: {
                            Text("Current workout")
                        }
                    }
                    
                    WorkoutList(contains: queryString) { workout in
                        NavigationLink(destination: WorkoutDetailScreen(workout: workout, showingActiveWorkout: $showingActiveWorkout, hasActiveWorkout: !workoutLogs.isEmpty)) {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(workout.wrappedName)
                            }
                        }
                    }
                }

                NavigationLink(destination: ActiveWorkoutScreen(workoutLog: workoutLogs.first, showingActiveWorkout: $showingActiveWorkout), isActive: $showingActiveWorkout) {
                    EmptyView()
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
            .searchable(text: $queryString)
        }
    }
}

struct WorkoutListScreen_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutListScreen()
    }
}
