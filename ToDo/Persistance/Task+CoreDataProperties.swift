//
//  Task+CoreDataProperties.swift
//  
//
//  Created by Alexander on 09.04.2020.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var blue: Float
    @NSManaged public var descript: String?
    @NSManaged public var green: Float
    @NSManaged public var id: UUID
    @NSManaged public var red: Float
    @NSManaged public var title: String

}
