//
//  WorkoutLogDetailScreen.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/21/23.
//

import SwiftUI

private struct ExerciseCell: View {
    var exerciseLog: ExerciseLog
    
    var body: some View {
        HStack {
            Text(exerciseLog.wrappedExerciseName)
            Spacer()
            Text("\(exerciseLog.workoutExercise?.reps ?? 0)x\(exerciseLog.workoutExercise?.sets ?? 0)")
        }
        .foregroundColor(.primary)
    }
}

struct WorkoutLogDetailScreen: View {
    @Environment(\.managedObjectContext) var moc
    @State private var showingDelete = false
    var workoutLog: WorkoutLog
    
    var completedExercises: [ExerciseLog] { workoutLog.exerciseLogArray.filter({ $0.isCompleted }) }
    var skippedExercises: [ExerciseLog] { workoutLog.exerciseLogArray.filter({ !$0.isCompleted }) }
    
    var body: some View {
        List {
            Section {
                if completedExercises.isEmpty {
                    Text("We should probably remove this one.")
                } else {
                    ForEach(completedExercises) {
                        ExerciseCell(exerciseLog: $0)
                    }
                }
                    
            } header: {
                Text("Completed")
            }
            
            Section {
                if skippedExercises.isEmpty {
                    Text("Good Job, no exercises were skipped.")
                } else {
                    ForEach(skippedExercises) {
                        ExerciseCell(exerciseLog: $0)
                    }
                }
            } header: {
                Text("Skipped")
            }
        }
        .listStyle(.sidebar)
        .navigationTitle(workoutLog.workout?.wrappedName ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete Workout Log", isPresented: $showingDelete, actions: {
            Button("Delete", role: .destructive) {
                moc.delete(workoutLog)
            }
        }, message: {
            Text("Are you sure you want to delete this log of \(workoutLog.workout?.wrappedName ?? "")?")
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingDelete = true
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
    }
}

//struct WorkoutLogDetailScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkoutLogDetailScreen()
//    }
//}
