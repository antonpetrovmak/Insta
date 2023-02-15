//
//  UserProvider.swift
//  Insta
//
//  Created by Petrov Anton on 14.02.2023.
//

import Foundation

struct UserProvider {
    let networkManager: NetworkManager
    
    private static func getUsers(page: Int) -> URL { URL(string: "https://reqres.in/api/users?page=\(page)")! }
    
    func fetchUsers(page: Int) async throws -> PageData<UserDTO> {
        let url = Self.getUsers(page: page)
        let pageData: PageData<UserDTO> = try await networkManager.perform(url: url)
        return pageData
    }
}
