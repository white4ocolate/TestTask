//
//  Data+Extension.swift
//  TestTask
//

import Foundation

extension Data {
    /// Appends a UTF-8 encoded string to the existing `Data` buffer.
    ///
    /// This is particularly useful when constructing HTTP body content manually,
    /// such as multipart/form-data requests.
    ///
    /// - Parameter string: The `String` to encode and append.
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
