//
//  User.swift
//  TestTask
//

import Foundation

struct User: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
    let email: String
    let phone: String
    let position: String
    let photo: String
}
