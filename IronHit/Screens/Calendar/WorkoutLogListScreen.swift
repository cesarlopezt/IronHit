//
//  WorkoutLogListScreen.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/20/23.
//

import SwiftUI

struct WorkoutLogListScreen: View {
    @SectionedFetchRequest(
        entity: WorkoutLog.entity(),
        sectionIdentifier: \.dateString,
        sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)]
    ) var workoutLogsByDay: SectionedFetchResults<String, WorkoutLog>
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(workoutLogsByDay) { day in
                        Section {
                            ForEach(day) { workoutLog in
                                HStack {
                                    Text(workoutLog.workout?.wrappedName ?? "")
                                    Spacer()
                                    if(!workoutLog.isCompleted) {
                                        Text("CURRENT")
                                            .textCase(.uppercase)
                                            .font(.caption2)
                                            .padding(5)
                                            .background(.green.opacity(0.3))
                                            .clipShape(RoundedRectangle(cornerRadius: 5))
                                    }
                                }
                            }
                        } header: {
                            Text(parseDate(from: day.id).formatted(date: .complete, time: .omitted))
                        }
                    }
                }
            }
            .navigationTitle("Calendar")
        }
    }
    
    func parseDate(from dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from:dateString) ?? Date.now
    }
}

struct WorkoutLogListScreen_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutLogListScreen()
    }
}
