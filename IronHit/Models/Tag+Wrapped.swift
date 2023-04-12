//
//  Tag+Wrapped.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/12/23.
//

import Foundation

extension Tag {
    public var wrappedName: String {
        name ?? ""
    }
    
    public var exerciseArray: [Exercise] {
        let set = exercises as? Set<Exercise> ?? []
        
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}
