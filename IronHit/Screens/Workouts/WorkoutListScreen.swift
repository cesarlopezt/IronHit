//
//  WorkoutListScreen.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/13/23.
//

import SwiftUI

class NavigationHandler: ObservableObject {
    @Published var path = NavigationPath()
    
    func removeAll() {
        path.removeLast(path.count)
    }
}

struct WorkoutListScreen: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var workouts: FetchedResults<Workout>
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "isCompleted == false")) var workoutLogs: FetchedResults<WorkoutLog>
    @State private var showingAddWorkout = false
    @State private var queryString = ""
    @StateObject var navigationHandler = NavigationHandler()
    
    var body: some View {
        NavigationStack(path: $navigationHandler.path) {
            VStack {
                WorkoutList(
                    contains: queryString,
                    showingAddWorkout: $showingAddWorkout,
                    usingFilters: !queryString.isEmpty
                ) { workout in
                    NavigationLink(
                        destination: WorkoutDetailScreen(
                            workout: workout,
                            hasActiveWorkout: !workoutLogs.isEmpty
                        )
                    ) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(workout.wrappedName)
                        }
                    }
                }  activeWorkout: {
                    Group {
                        if (!workoutLogs.isEmpty) {
                            Section {
                                ForEach(workoutLogs) { workoutLog in
                                    NavigationLink(workoutLog.wrappedWorkoutName, value: workoutLog)
                                }
                            } header: {
                                Text("Current workout")
                            }
                        } else {
                            EmptyView()
                        }
                    }
                }
            }
            .navigationTitle("Workouts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    // TODO: Adapt to new iOS navigation API and fix this deprecation
                    NavigationLink(
                        destination: AddWorkoutScreen(moc: moc, showingAddWorkout: $showingAddWorkout),
                        isActive: $showingAddWorkout
                    ) {
                        Label("Add Workout", systemImage: "plus")
                    }
                }
            }
            .searchable(text: $queryString)
            .navigationDestination(for: WorkoutLog.self) { workoutLog in
                ActiveWorkoutScreen(workoutLog: workoutLogs.first)
            }
        }
        .environmentObject(navigationHandler)
    }
}

struct WorkoutListScreen_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutListScreen()
    }
}
