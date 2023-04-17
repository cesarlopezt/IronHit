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
            if (workout.desc != nil) {
                Section {
                    Text(workout.desc ?? "")
                } header: {
                    Text("Description")
                }
            }
            Section {
                ForEach(workout.exerciseEntriesArray) {
                    RepsSchemeCell(exerciseName: $0.exercise?.wrappedName ?? "", reps: $0.reps, sets: $0.sets)
                }
            } header: {
                Text("Exercises")
            }
        }
        .navigationTitle(workout.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
    }
}
