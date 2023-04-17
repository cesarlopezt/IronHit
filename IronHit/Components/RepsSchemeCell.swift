//
//  RepsSchemeCell.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/17/23.
//

import SwiftUI

struct RepsSchemeCell: View {
    var exerciseName: String
    var reps: Int16
    var sets: Int16
    var showReorder = false
    
    var body: some View {
        HStack {
            if (showReorder) {
                Image(systemName: "line.3.horizontal")
                    .foregroundColor(.primary.opacity(0.2))
            }
            Text(exerciseName)
            Spacer()
            Text("\(reps) x \(sets)")
        }
    }
}

struct RepsSchemeCell_Previews: PreviewProvider {
    static var previews: some View {
        RepsSchemeCell(exerciseName: "Triceps Extension", reps: 12, sets: 2)
    }
}
