//
//  ValidationRules.swift
//  TestTask
//

import Foundation

/// Validation rules applied to form fields
enum ValidationRule {
    /// Field must not be empty
    case required(message: String = "Required field")

    /// Field must contain between 2 and 60 characters
    case moreCharacter(message: String = "Your should be 2-60 characters")

    /// Field must be a valid email address
    case email(message: String = "Invalid email format")

    /// Field must contain a Ukrainian phone number (10 digits)
    case phoneUA(message: String = "Phone number is too short")
}

class FieldValidator {
    /// Validates the given `value` using the provided list of validation `rules`
    ///
    /// - Parameters:
    ///   - value: The input string to validate
    ///   - rules: An array of validation rules to apply
    /// - Returns: An error message if a rule fails, or `nil` if validation succeeds
    static func validate(_ value: String, rules: [ValidationRule]) -> String? {
        for rule in rules {
            switch rule {
            case .required(let message):
                // Trim whitespace and check for empty string
                if value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    return message
                }
            case .moreCharacter(let message):
                let value = value.trimmingCharacters(in: .whitespacesAndNewlines)
                if value.count < 2 || value.count > 60 {
                    return message
                }
            case .email(let message):
                // Simple regex for email validation
                let regex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
                if !NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: value) {
                    return message
                }
            case .phoneUA(let message):
                // Extract digits only and check for exact 10 digits
                let digits = value.filter { $0.isNumber }
                if digits.count != 10 {
                    return message
                }
            }
        }
        // All rules passed
        return nil
    }
}
