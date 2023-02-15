//
//  PostProvider.swift
//  Insta
//
//  Created by Petrov Anton on 14.02.2023.
//

import Foundation

struct PostProvider {
    let networkManager: NetworkManager
    
    private static func getPosts(page: Int) -> URL { URL(string: "https://reqres.in/api/unknown?page=\(page)")! }
    
    func fetchPosts(page: Int) async throws -> PageData<PostDTO> {
        let url = Self.getPosts(page: page)
        let pageData: PageData<PostDTO> = try await networkManager.perform(url: url)
        return pageData
    }
}
