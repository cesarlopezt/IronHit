//
//  ActiveWorkoutScreen.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/17/23.
//

import SwiftUI

struct ActiveWorkoutScreen: View {
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "isCompleted == false")) var workoutLogs: FetchedResults<WorkoutLog>
    
    var body: some View {
        VStack {
            if let activeWorkoutLog = workoutLogs.first {
                Text(activeWorkoutLog.workout?.wrappedName ?? "")
            } else {
                Text("Sorry, no workout found")
            }
        }
        .navigationTitle("Current Workout")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ActiveWorkoutScreen_Previews: PreviewProvider {
    static var previews: some View {
        ActiveWorkoutScreen()
    }
}
