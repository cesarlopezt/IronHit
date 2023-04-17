//
//  WorkoutDetailScreen.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/15/23.
//

import SwiftUI

//private struct ExerciseCell: View {
//    var body: some View {
//        HStack {
//            Text($0.exercise?.wrappedName ?? "")
//        }
//    }
//}

struct WorkoutDetailScreen: View {
    let workout: Workout
    
    var body: some View {
        Form {
            Section {
                ForEach(workout.exerciseEntriesArray) {
                    Text($0.exercise?.wrappedName ?? "")
                }
            }
        }
    }
}
