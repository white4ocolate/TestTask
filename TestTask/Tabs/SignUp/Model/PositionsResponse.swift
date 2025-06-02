//
//  PositionsResponse.swift
//  TestTask
//

import Foundation

// A model for decoding the response from the server when fetching available user positions
struct PositionsResponse: Codable {
    let success: Bool
    let positions: [Position]?
}
