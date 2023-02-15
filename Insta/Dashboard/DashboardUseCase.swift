//
//  DashboardUseCase.swift
//  Insta
//
//  Created by Petrov Anton on 14.02.2023.
//

import Foundation

struct DashboardUseCase {
    let userProvider: UserProvider
    let postProvider: PostProvider
    let persistence: PersistenceController
    
    /// Fetch and store users
    /// - Parameter page: number of loaded page
    /// - Returns: count of total pages
    func loadStories(page: Int) async throws -> Int {
        let usersDTOs = try await userProvider.fetchUsers(page: page)
        try await persistence.importItems(usersDTOs.data) { (dto: UserDTO, model: User) in
            model.id = Int64(dto.id)
            model.firstName = dto.firstName
            model.lastName = dto.lastName
            model.avatar = URL(string: dto.avatar)
        }
        return usersDTOs.totalPages
    }
    
    /// Fetch and store posts
    /// - Parameter page: number of loaded page
    /// - Returns: count of total pages
    func loadPosts(page: Int) async throws -> Int {
        let postsDTOs = try await postProvider.fetchPosts(page: page)
        try await persistence.importItems(postsDTOs.data) { (dto: PostDTO, model: Post) in
            model.id = Int64(dto.id)
            model.name = dto.name
            model.color = dto.color
        }
        return postsDTOs.totalPages
    }
}
