//
//  Emoji+CoreDataProperties.swift
//  EmojiDictionaryCoreDataProgrammatic
//
//  Created by Julian Worden on 7/21/22.
//
//

import Foundation
import CoreData


extension Emoji {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Emoji> {
        return NSFetchRequest<Emoji>(entityName: "Emoji")
    }

    @NSManaged public var symbol: String?
    @NSManaged public var name: String?
    @NSManaged public var details: String?
    @NSManaged public var usage: String?

}

extension Emoji : Identifiable {

}
