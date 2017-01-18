//
//  Note+CoreDataProperties.swift
//  Notas
//
//  Created by jose luis sanchez-porro godoy on 16/01/2017.
//  Copyright © 2017 jose luis sanchez-porro godoy. All rights reserved.
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var image: NSData?
    @NSManaged public var text: String?

}
