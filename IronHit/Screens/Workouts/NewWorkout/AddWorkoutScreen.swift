//
//  AddWorkoutScreen.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/13/23.
//

import CoreData
import SwiftUI

struct AddWorkoutScreen: View {
    @StateObject var addWorkoutService: AddWorkoutService
    @Binding var showingAddWorkout: Bool

    var body: some View {
        AddWorkoutExercisesScreen(addWorkoutService: addWorkoutService, showingAddWorkout: $showingAddWorkout)
    }
    
    init(moc: NSManagedObjectContext, showingAddWorkout: Binding<Bool>, workout: Workout? = nil) {
        self._showingAddWorkout = showingAddWorkout
        _addWorkoutService = StateObject(wrappedValue: AddWorkoutService(moc: moc))
    }
}
