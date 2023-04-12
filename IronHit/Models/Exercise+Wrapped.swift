//
//  Exercise+Wrapped.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/12/23.
//

import Foundation

extension Exercise {
    public var wrappedName: String {
        name ?? ""
    }
    
    public var tagArray: [Tag] {
        let set = tags as? Set<Tag> ?? []
        
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}
