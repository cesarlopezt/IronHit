//
//  ExerciseDetailScreen.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/19/23.
//

import SwiftUI

struct ExerciseDetailScreen: View {
    @Environment(\.managedObjectContext) var moc;
    var exercise: Exercise
    @State private var showingDelete = false
    
    var body: some View {
        Form {
            Section {
                Text(exercise.desc ?? "")
            } header: {
                Text("Description")
            }
        }
        .navigationTitle(exercise.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete Exercise", isPresented: $showingDelete, actions: {
            Button("Delete", role: .destructive) { deleteExercise() }
        }, message: {
            Text("Are you sure you want to delete \(exercise.wrappedName)?")
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
    
    func deleteExercise() {
        exercise.isShown = false
        try? moc.save()
    }
}

//struct ExerciseDetailScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        ExerciseDetailScreen()
//    }
//}
