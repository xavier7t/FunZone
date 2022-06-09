//
//  Note+CoreDataProperties.swift
//  FunZone
//
//  Created by Xavier on 6/5/22.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var body: String?
    @NSManaged public var title: String?

}

extension Note : Identifiable {

}
