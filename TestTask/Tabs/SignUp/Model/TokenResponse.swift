//
//  TokenResponse.swift
//  TestTask
//

import Foundation

// Represents the response structure received after requesting a token from the server
struct TokenResponse: Codable {
    let success: Bool
    let token: String
}
