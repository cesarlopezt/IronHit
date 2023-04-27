//
//  ExerciseLog+Wrapped.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/26/23.
//

import Foundation

extension ExerciseLog {
    public var wrappedExerciseName: String {
        exercise?.name ?? ""
    }
}
