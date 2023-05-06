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
            if let exercise = workoutExercise.exercise {
                ExerciseDetailScreen(exercise: exercise, isViewOnlyMode: true)
            } else {
                EmptyView()
            }
        } label: {
            RepsSchemeCell(exerciseName: workoutExercise.wrappedExerciseName, reps: workoutExercise.reps, sets: workoutExercise.sets)
        }
    }
}


struct WorkoutDetailScreen: View {
    @EnvironmentObject var navigationHandler: NavigationHandler
    @Environment(\.managedObjectContext) var moc
    var workout: Workout
    @State private var showingDelete = false
    @State private var showingEditWorkout = false
    
    // Active workout management
    var hasActiveWorkout: Bool
    var isViewOnlyMode: Bool = false
    
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
            if (!isViewOnlyMode) {
                Button("Start workout") {
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
                    try? moc.save()
                    navigationHandler.removeAll()
                    navigationHandler.path.append(workoutLog)
                }
                .font(.title3)
                .buttonStyle(.borderedProminent)
                .padding(.bottom, 20)
                .disabled(hasActiveWorkout)
            }
        }
        .navigationTitle(workout.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete Workout", isPresented: $showingDelete, actions: {
            Button("Delete", role: .destructive) { deleteWorkout() }
        }, message: {
            Text("Are you sure you want to delete \(workout.wrappedName)?")
        }) 
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if (!isViewOnlyMode) {
                    HStack {
                        NavigationLink(value: WorkoutDestination(workout: workout, destination: "edit")) {
                            Label("Edit Workout", systemImage: "square.and.pencil")
                        }
                        Button {
                            showingDelete = true
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
        }
    }
    
    func deleteWorkout() {
        workout.isShown = false
        try? moc.save()
        navigationHandler.removeAll()
    }
}
