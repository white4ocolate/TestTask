//
//  UserResponse.swift
//  TestTask
//

import Foundation

// Response model for users API call
struct UsersResponse: Codable {
    let success: Bool
    let total_pages: Int
    let total_users: Int
    let count: Int
    let page: Int
    let users: [User]?
}
