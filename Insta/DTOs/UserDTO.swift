//
//  UserDTO.swift
//  Insta
//
//  Created by Petrov Anton on 14.02.2023.
//

import Foundation

struct PageData<T: Decodable>: Decodable {
    let page: Int // 2
    let perPage: Int // 6
    let total: Int // 12,
    let totalPages: Int // 2,
    let data: [T]
}

struct UserDTO: Decodable {
    let id: Int // 7,
    let firstName: String // "Michael",
    let lastName: String // "Lawson",
    let avatar: String // "https://reqres.in/img/faces/7-image.jpg"
}

struct PostDTO: Decodable {
    let id: Int // 7,
    let name: String // "cerulean",
    let color: String // "#98B2D1",
}
