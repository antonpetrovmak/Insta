//
//  DashboardViewModel.swift
//  Insta
//
//  Created by Petrov Anton on 14.02.2023.
//

import Foundation

final class DashboardViewModel: DashboardVMP {
    
    @Published private(set) var isLoading: Bool = false
    
    private let dashboardUseCase: DashboardUseCase
    
    private var totalPostPages: Int = 1
    private var currentPostPage: Int = 1
    private var totalUsersPages: Int = 1
    private var currentUserPage: Int = 1
    
    init(dashboardUseCase: DashboardUseCase) {
        self.dashboardUseCase = dashboardUseCase
    }
    
    // MARK: - Public Methods of DashboardVMP
    func onAppear() {
        Task {
            await setLoading(true)
            
            await withTaskGroup(of: Void.self, body: { taskGroup in
                taskGroup.addTask { try? await self.loadUsers() }
                taskGroup.addTask { try? await self.loadPosts() }
            })
            
            await setLoading(false)
        }
    }
    
    func loadMorePosts() {
        guard currentPostPage < totalPostPages else { return }
        currentPostPage += 1
        Task {
            await MainActor.run {
                isLoading = true
            }
            try? await loadPosts()
            await MainActor.run {
                isLoading = false
            }
        }
    }
    
    func loadMoreStories() {
        guard currentUserPage < totalUsersPages else { return }
        currentUserPage += 1
        Task {
            await setLoading(true)
            try? await loadUsers()
            await setLoading(false)
        }
    }
    
    // MARK: - Private Methods
    @MainActor
    private func setLoading(_ isOn: Bool) async {
        isLoading = isOn
    }
    
    private func loadPosts() async throws {
        totalPostPages = try await dashboardUseCase.loadPosts(page: currentPostPage)
    }
    
    private func loadUsers() async throws {
        totalUsersPages = try await dashboardUseCase.loadStories(page: currentUserPage)
    }
}
