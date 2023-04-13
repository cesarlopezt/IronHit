//
//  TagsList.swift
//  IronHit
//
//  Created by Cesar Lopez on 4/12/23.
//

import SwiftUI

struct TagsList: View {
    var tags: [Tag]
    
    var body: some View {
        HStack {
            ForEach(tags) { tag in
                Text(tag.wrappedName)
                    .font(.caption2)
                    .padding(5)
                    .background(.blue.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            }
        }
    }
}

struct TagsList_Previews: PreviewProvider {
    static var previews: some View {
        TagsList(tags: [])
    }
}
