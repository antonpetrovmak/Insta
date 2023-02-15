//
//  User+CoreDataClass.swift
//  Insta
//
//  Created by Petrov Anton on 14.02.2023.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {
    
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: Int64
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var avatar: URL?
    @objc public var fullName: String {
        return "\(firstName ?? "") \(lastName ?? "")"
    }
}
