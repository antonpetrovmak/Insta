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
        loadUsers()
        loadPosts()
    }
    
    func loadMorePosts() {
        guard currentPostPage < totalPostPages else { return }
        currentPostPage += 1
        loadPosts()
    }
    
    func loadMoreStories() {
        guard currentUserPage < totalUsersPages else { return }
        currentUserPage += 1
        loadUsers()
    }
    
    // MARK: - Private Methods
    private func loadPosts() {
        Task { [weak self] in
            self?.totalPostPages = try await dashboardUseCase.loadPosts(page: currentPostPage)
        }
    }
    
    private func loadUsers() {
        Task { [weak self] in
            self?.totalUsersPages = try await dashboardUseCase.loadStories(page: currentUserPage)
        }
    }
}
