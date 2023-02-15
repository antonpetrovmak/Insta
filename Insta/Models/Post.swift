//
//  Post+CoreDataClass.swift
//  Insta
//
//  Created by Petrov Anton on 14.02.2023.
//
//

import Foundation
import CoreData

@objc(Post)
public class Post: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String
    @NSManaged public var color: String
}
