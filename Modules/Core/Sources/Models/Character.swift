//
//  Character.swift
//  Models
//
//  Created by Rafael Bartolome on 21/03/2020.
//  Copyright © 2020 Rafael Bartolome. All rights reserved.
//

import Foundation

public struct Character {    
    public let id: Int
    public let name: String
    public let bio: String
    public let thumbnailURL: URL?
    public let modified: Date
    
    public init(id: Int, name: String, bio: String, thumbnailURL: URL?, modified: Date) {
        self.id = id
        self.name = name
        self.bio = bio
        self.thumbnailURL = thumbnailURL
        self.modified = modified
    }

}
