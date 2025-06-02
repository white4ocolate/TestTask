//
//  ValidationRules.swift
//  TestTask
//

import Foundation

enum ValidationRule {
    case required(message: String = "Required field")
    case moreCharacter(message: String = "Your should be 2-60 characters")
    case email(message: String = "Invalid email format")
    case phoneUA(message: String = "Phone number is too short")
}

class FieldValidator {
    static func validate(_ value: String, rules: [ValidationRule]) -> String? {
        for rule in rules {
            switch rule {
            case .required(let message):
                if value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    return message
                }
            case .moreCharacter(let message):
                let value = value.trimmingCharacters(in: .whitespacesAndNewlines)
                if value.count < 2 || value.count > 60 {
                    return message
                }
            case .email(let message):
                let regex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
                if !NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: value) {
                    return message
                }
            case .phoneUA(let message):
                let digits = value.filter { $0.isNumber }
                if digits.count != 10 {
                    return message
                }
            }
        }
        return nil
    }
}
