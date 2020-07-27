//
//  CharacterEntity.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 26/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import CoreData

public class CharacterEntity: NSManagedObject, Identifiable {
    @NSManaged public var id: Int32
    @NSManaged public var name: String
    @NSManaged public var desc: String
    @NSManaged public var favorite: Bool
    @NSManaged public var path: String
    @NSManaged public var `extension`: String
    @NSManaged public var image: Data?
}
