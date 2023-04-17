//
//  WorkoutDetailScreen.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/15/23.
//

import SwiftUI

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
