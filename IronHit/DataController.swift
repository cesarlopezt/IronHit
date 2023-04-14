//
//  DataController.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/10/23.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "IronHit")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error {
                fatalError("Core data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
