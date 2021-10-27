//
//  Employee+CoreDataProperties.swift
//  CoreDataCRUOperations
//
//  Created by Field Employee on 10/27/21.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var name: String?
    @NSManaged public var address: String?
    @NSManaged public var id: Float
    @NSManaged public var company: Company?

}

extension Employee : Identifiable {

}
