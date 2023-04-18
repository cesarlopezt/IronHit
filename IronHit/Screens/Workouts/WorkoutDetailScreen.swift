//
//  WorkoutDetailScreen.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/15/23.
//

import SwiftUI

private struct ExerciseCell: View {
    var workoutExercise: WorkoutExercise
    var body: some View {
        NavigationLink {
            Text("Exercise detail")
        } label: {
            RepsSchemeCell(exerciseName: workoutExercise.exercise?.wrappedName ?? "", reps: workoutExercise.reps, sets: workoutExercise.sets)
        }
    }
}


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
                    ExerciseCell(workoutExercise: $0)
                }
            } header: {
                Text("Exercises")
            }
        }
        .overlay(alignment: .bottom) {
            Button {
                
            } label: {
                Label("Start workout", systemImage: "play.fill")
                    .foregroundColor(.white)
                    .font(.title3)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.bottom, 20)
        }

        .navigationTitle(workout.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
    }
}
