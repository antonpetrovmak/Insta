//
//  Persistence.swift
//  Insta
//
//  Created by Petrov Anton on 14.02.2023.
//

import CoreData
import OSLog

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    private let logger = Logger(subsystem: "com.Insta", category: "Repository")
    
    private init() {
        container = NSPersistentContainer(name: "Insta")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    // NOTE: we can use NSBatchInsertRequest if the dataset will be larger
    func importItems<DTO, Model: NSManagedObject>(_ items: [DTO], transform: @escaping (DTO, Model) -> Void) async throws {
        guard !items.isEmpty else { return }
        let privateContext = container.newBackgroundContext()
        
        privateContext.name = "Insert \(String(describing: Model.self))"
        privateContext.transactionAuthor = "Import \(String(describing: Model.self))"
        
        try await privateContext.perform {
            self.logger.debug("Start insert \(String(describing: Model.self))(s) count: \(items.count)")
            items.forEach { dto in
                transform(dto, Model(context: privateContext))
            }
            try privateContext.save()
            self.logger.debug("Finish insert \(String(describing: Model.self))(s)")
        }
    }
}
