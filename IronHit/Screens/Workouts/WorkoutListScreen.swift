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

struct WorkoutDestination: Hashable {
    var workout: Workout
    var destination: String
}

struct WorkoutListScreen: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var workouts: FetchedResults<Workout>
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "isCompleted == false")) var workoutLogs: FetchedResults<WorkoutLog>
    @State private var queryString = ""
    @StateObject var navigationHandler = NavigationHandler()
    
    var body: some View {
        NavigationStack(path: $navigationHandler.path) {
            VStack {
                WorkoutList(
                    contains: queryString,
                    usingFilters: !queryString.isEmpty
                ) { workout in
                    NavigationLink(value: WorkoutDestination(workout: workout, destination: "detail")) {
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
                    NavigationLink(value: "addWorkout") {
                        Label("Add Workout", systemImage: "plus")
                    }
                }
            }
            .searchable(text: $queryString)
            .navigationDestination(for: WorkoutLog.self) { workoutLog in
                ActiveWorkoutScreen(workoutLog: workoutLogs.first)
            }
            .navigationDestination(for: String.self) { val in
                if val == "addWorkout" {
                    AddWorkoutScreen(moc: moc)
                }
            }
            .navigationDestination(for: WorkoutDestination.self) { workoutDestination in
                if workoutDestination.destination == "detail" {
                    WorkoutDetailScreen(
                        workout: workoutDestination.workout,
                        hasActiveWorkout: !workoutLogs.isEmpty
                    )
                } else if workoutDestination.destination == "edit" {
                    AddWorkoutScreen(moc: moc, workout: workoutDestination.workout)
                }
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
