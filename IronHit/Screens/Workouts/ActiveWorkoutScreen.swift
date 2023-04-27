//
//  ActiveWorkoutScreen.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/17/23.
//

import SwiftUI

private struct ExerciseCell: View {
    var exerciseLog: ExerciseLog
    var isStriked: Bool = false
    var onTap: () -> Void
    
    var body: some View {
        Button {
            onTap()
        } label: {
            HStack {
                Image(systemName: exerciseLog.isCompleted ? "checkmark.circle.fill" : "circle")
                Text(exerciseLog.wrappedExerciseName)
                    .strikethrough(isStriked)
                Spacer()
                Text("\(exerciseLog.workoutExercise?.reps ?? 0)x\(exerciseLog.workoutExercise?.sets ?? 0)")
            }
            .foregroundColor(.primary)
        }
    }
}

struct ActiveWorkoutScreen: View {
    @Environment(\.managedObjectContext) var moc
    var workoutLog: WorkoutLog?
    @FetchRequest var completedExerciseLogs: FetchedResults<ExerciseLog>
    @FetchRequest var exerciseLogs: FetchedResults<ExerciseLog>
    @State private var isWorkoutDone = false
    @State private var showingWorkoutDetail: Bool = false
    @Binding var showingActiveWorkout: Bool

    var body: some View {
        if let workoutLog, let workout = workoutLog.workout {
            List {
                Section {
                    if (exerciseLogs.isEmpty) {
                        Text("Looks like you are done with this workout!")
                    } else {
                        ForEach(exerciseLogs) { exerciseLog in
                            ExerciseCell(exerciseLog: exerciseLog) {
                                toggleExerciseLog(exerciseLog: exerciseLog)
                            }
                        }
                    }
                } header: {
                    Text("Exercises")
                }
                
                if (!completedExerciseLogs.isEmpty) {
                    Section {
                        ForEach(completedExerciseLogs) { exerciseLog in
                            ExerciseCell(exerciseLog: exerciseLog, isStriked: true) {
                                toggleExerciseLog(exerciseLog: exerciseLog)
                            }
                        }
                    } header: {
                        Text("Completed")
                    }
                }
                
                Button("Done") {
                    isWorkoutDone = true
                }
            }
            .navigationTitle(workout.wrappedName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem {
                    Button {
                        showingWorkoutDetail = true
                    } label: {
                        Label("Workout Detail", systemImage: "info.circle")
                    }
                }
            })
            .alert("Workout complete?", isPresented: $isWorkoutDone) {
                Button("Not yet") {}
                Button("Yes") { finishWorkout(workoutLog: workoutLog) }
            }
            .sheet(isPresented: $showingWorkoutDetail) {
                NavigationView {
                    WorkoutDetailScreen(workout: workout, showingActiveWorkout: $showingActiveWorkout, hasActiveWorkout: true, isViewMode: true)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button("Close") {
                                    showingWorkoutDetail = false
                                }
                            }
                        }
                }
            }
        }
        else {
            Text("Sorry, workout not found, try again.")
                .navigationTitle("Not found")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func finishWorkout(workoutLog: WorkoutLog) {
        workoutLog.isCompleted = true
        workoutLog.finishedAt = Date.now
        try? moc.save()
        showingActiveWorkout = false
    }

    func toggleExerciseLog(exerciseLog: ExerciseLog) -> Void {
        exerciseLog.isCompleted.toggle()
        // TODO: I probably don't need to save on each click
        try? moc.save()
    }
    
    init(workoutLog: WorkoutLog?, showingActiveWorkout: Binding<Bool>) {
        self._showingActiveWorkout = showingActiveWorkout
        if let workoutLog {
            self.workoutLog = workoutLog
            _completedExerciseLogs = FetchRequest<ExerciseLog>(sortDescriptors: [SortDescriptor(\.workoutExercise?.order)], predicate: NSPredicate(format: "isCompleted == true AND workoutLog == %@", workoutLog))
            _exerciseLogs = FetchRequest<ExerciseLog>(sortDescriptors: [SortDescriptor(\.workoutExercise?.order)], predicate: NSPredicate(format: "isCompleted == false AND workoutLog == %@", workoutLog))
        } else {
            self.workoutLog = workoutLog
            // TODO: There is no need to run this fetch requests to show an empty screen, should thing about how I will solve this
            _completedExerciseLogs = FetchRequest<ExerciseLog>(sortDescriptors: [])
            _exerciseLogs = FetchRequest<ExerciseLog>(sortDescriptors: [])
        }
    }
}
