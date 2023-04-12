//
//  ExerciseList.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/12/23.
//

import SwiftUI

struct ExerciseList: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var exercises: FetchedResults<Exercise>
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(exercises, id: \.id) { exercise in
                        VStack(alignment: .leading, spacing: 5) {
                            Text(exercise.name ?? "")
                            HStack {
                                ForEach(exercise.tagArray) { tag in
                                    Text(tag.wrappedName)
                                        .font(.caption2)
                                        .padding(5)
                                        .background(.blue.opacity(0.3))
                                        .clipShape(Capsule())
                                }
                            }
                        }
                    }
                }
                Button("Add mock data") {
                    let armTag = Tag(context: moc)
                    armTag.id = UUID()
                    armTag.name = "Arm"
                    
                    let bicepTag = Tag(context: moc)
                    bicepTag.id = UUID()
                    bicepTag.name = "Bicep"
                    
                    let tricepTag = Tag(context: moc)
                    tricepTag.id = UUID()
                    tricepTag.name = "Tricep"
                    
                    let backTag = Tag(context: moc)
                    backTag.id = UUID()
                    backTag.name = "Back"
                    
                    let exercise1 = Exercise(context: moc)
                    exercise1.id = UUID()
                    exercise1.name = "Bicep Curl"
                    exercise1.desc = "Test Descr"
                    exercise1.tags = NSSet(array: [armTag, bicepTag])
                    
                    let exercise2 = Exercise(context: moc)
                    exercise2.id = UUID()
                    exercise2.name = "Tricep Extension"
                    exercise2.desc = "Test Descr"
                    exercise2.tags = NSSet(array: [armTag, tricepTag])
                    
                    let exercise3 = Exercise(context: moc)
                    exercise3.id = UUID()
                    exercise3.name = "PullUps"
                    exercise3.desc = "Test Descr"
                    exercise3.tags = NSSet(array: [backTag])
                    
                    let exercise4 = Exercise(context: moc)
                    exercise4.id = UUID()
                    exercise4.name = "ChinUps"
                    exercise4.desc = "Test Descr"
                    exercise4.tags = NSSet(array: [armTag, bicepTag])
                }
            }
            .navigationTitle("Exercises")
        }
    }
}

struct ExerciseList_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
