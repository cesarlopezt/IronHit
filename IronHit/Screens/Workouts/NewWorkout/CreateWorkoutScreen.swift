//
//  CreateWorkoutScreen.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/14/23.
//

import SwiftUI


struct CreateWorkoutScreen: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var navigationHandler: NavigationHandler
    @ObservedObject var addWorkoutService: AddWorkoutService
    @FocusState private var descriptionFocused: Bool
    
    var body: some View {
        Form {
            TextField("Name", text: $addWorkoutService.name)
            
            Section {
                TextEditor(text: $addWorkoutService.description)
                    .frame(height: 200)
                    .focused($descriptionFocused)
            } header: {
                Text("Description")
            }
            
            Section {
                ForEach(addWorkoutService.workoutExercises) {
                    RepsSchemeCell(exerciseName: $0.wrappedExerciseName, reps: $0.reps, sets: $0.sets, showReorder: true)
                }
                .onMove { source, destination in
                    addWorkoutService.workoutExercises.move(fromOffsets: source, toOffset: destination)
                }
            }
        header: {
                Text("Exercises")
            }
        }
        .navigationTitle("New workout")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    addWorkoutService.saveWorkout()
                    navigationHandler.removeAll()
                }
                .disabled(addWorkoutService.isSaveDisabled)
            }
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("OK") {
                    descriptionFocused = false
                }
            }
        }
    }
}
