//
//  User.swift
//  TestTask
//

import Foundation

// Model representing a user entity returned from the API
struct User: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
    let email: String
    let phone: String
    let position: String
    let photo: String
}
