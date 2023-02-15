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
    let networkManager = NetworkManager.shared

    var body: some Scene {
        WindowGroup {
            NavigationView {
                let userProvider = UserProvider(networkManager: networkManager)
                let postProvider = PostProvider(networkManager: networkManager)
                let dashboardUseCase = DashboardUseCase(userProvider: userProvider, postProvider: postProvider, persistence: persistenceController)
                let dashboardViewModel = DashboardViewModel(dashboardUseCase: dashboardUseCase)
                DashboardView(viewModel: dashboardViewModel)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
