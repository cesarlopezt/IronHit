//
//  AddWorkoutScreen.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/13/23.
//

import CoreData
import SwiftUI

struct AddWorkoutScreen: View {
    @StateObject var viewModel = ViewModel()

    var body: some View {
        SelectWorkoutExercisesScreen(viewModel: viewModel)
    }
}
