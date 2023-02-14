//
//  InstaApp.swift
//  Insta
//
//  Created by Petrov Anton on 14.02.2023.
//

import SwiftUI

@main
struct InstaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
