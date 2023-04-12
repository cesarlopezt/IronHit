//
//  ContentView.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/10/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ExerciseList()
                .tabItem {
                    Label("Exercise", systemImage: "dumbbell.fill")
                }
            ExerciseList()
                .tabItem {
                    Label("Workouts", systemImage: "figure.strengthtraining.traditional")
                }
            ExerciseList()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
