//
//  Position.swift
//  TestTask
//

import Foundation

// A model representing a user position, used for selection during sign-up
struct Position: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
}
