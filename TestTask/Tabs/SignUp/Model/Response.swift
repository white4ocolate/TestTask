//
//  Response.swift
//  TestTask
//

import Foundation

// A generic response model used for decoding basic success/failure responses from the server
struct Response: Codable {
    let success: Bool
    let message: String
}
