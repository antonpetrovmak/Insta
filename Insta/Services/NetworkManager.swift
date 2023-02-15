//
//  NetworkManager.swift
//  Insta
//
//  Created by Petrov Anton on 14.02.2023.
//

import Foundation

final class NetworkManager {
    
    static let shared: NetworkManager = .init()
    
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func perform<T: Decodable>(url: URL) async throws -> T {
        let session = URLSession.shared
        guard let (data, response) = try? await session.data(from: url),
              let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            throw InstaError.requestFailed
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw InstaError.decodingFailed(error: error)
        }
    }
}
