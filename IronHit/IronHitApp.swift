//
//  IronHitApp.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/10/23.
//

import SwiftUI

@main
struct IronHitApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
