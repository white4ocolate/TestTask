//
//  PositionsResponse.swift
//  TestTask
//

import Foundation

struct PositionsResponse: Codable {
    let success: Bool
    let positions: [Position]?
}
