//
//  ExerciseDetailScreen.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/19/23.
//

import SwiftUI

struct ExerciseDetailScreen: View {
    var exercise: Exercise
    
    var body: some View {
        Form {
            Section {
                Text(exercise.desc ?? "")
            } header: {
                Text("Description")
            }
        }
        .navigationTitle(exercise.wrappedName)
    }
}

//struct ExerciseDetailScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        ExerciseDetailScreen()
//    }
//}
