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
            ExerciseListScreen()
                .tabItem {
                    Label("Exercises", systemImage: "dumbbell.fill")
                }
            WorkoutListScreen()
                .tabItem {
                    Label("Workouts", systemImage: "figure.strengthtraining.traditional")
                }
            VStack {}
                .tabItem {
                    Label("PRs", systemImage: "medal")
                }
            VStack {}
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
