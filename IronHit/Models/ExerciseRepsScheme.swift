//
//  ExerciseRepsScheme.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/14/23.
//

import Foundation

struct ExerciseRepsScheme: Identifiable, Hashable {
    var id = UUID()
    var exercise: Exercise
    var reps: Int16
    var sets: Int16
}
