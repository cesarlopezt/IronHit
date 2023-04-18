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
    var workout: Workout
    @Binding var showingActiveWorkout: Bool
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        Form {
            if (workout.desc != nil && !workout.desc!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) {
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
                let workoutLog = WorkoutLog(context: moc)
                workoutLog.id = UUID()
                workoutLog.date = Date.now
                workoutLog.workout = workout
                workoutLog.isCompleted = false
                
                for exerciseEntry in workout.exerciseEntriesArray {
                    let exerciseLog = ExerciseLog(context: moc)
                    exerciseLog.id = UUID()
                    exerciseLog.exercise = exerciseEntry.exercise
                    exerciseLog.workoutLog = workoutLog
                    exerciseLog.workoutExercise = exerciseEntry
                    exerciseLog.isCompleted = false
                }
                showingActiveWorkout = true
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
