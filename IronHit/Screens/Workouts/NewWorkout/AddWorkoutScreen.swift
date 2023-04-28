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

    var body: some View {
        AddWorkoutExercisesScreen(addWorkoutService: addWorkoutService)
    }
    
    init(moc: NSManagedObjectContext, workout: Workout? = nil) {
        if let workout {
            _addWorkoutService = StateObject(wrappedValue: AddWorkoutService(moc: moc, workoutToEdit: workout))
        } else {
            _addWorkoutService = StateObject(wrappedValue: AddWorkoutService(moc: moc))
        }
    }
}
