//
//  AddWorkoutScreen.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/13/23.
//

import CoreData
import SwiftUI

struct AddWorkoutScreen: View {
    @StateObject var addWorkoutService = AddWorkoutService()
    @Binding var showingAddWorkout: Bool

    var body: some View {
        SelectWorkoutExercisesScreen(addWorkoutService: addWorkoutService, showingAddWorkout: $showingAddWorkout)
    }
}
