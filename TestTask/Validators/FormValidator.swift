//
//  FormValidator.swift
//  TestTask
//

import SwiftUI

/// A utility for validating form input data.
struct FormValidator {
    /// Validates all fields and returns errors and optional image data.
    static func validate(name: String, email: String, phone: String, image: UIImage?) -> (
        isValid: Bool,
        nameError: String?,
        emailError: String?,
        phoneError: String?,
        photoError: String?,
        imageData: Data?
    ) {
        // Name validation: must be non-empty and 2–60 characters
        let nameError = FieldValidator.validate(name, rules: [
            .moreCharacter(message: "Your should be 2-60 characters"),
            .required(message: "Required field")
        ])

        // Email validation: required and must match email pattern
        let emailError = FieldValidator.validate(email, rules: [
            .required(message: "Required field"),
            .email(message: "Invalid email format")
        ])

        // Phone validation: required and must match Ukrainian phone format
        let phoneError = FieldValidator.validate(phone, rules: [
            .required(message: "Required field"),
            .phoneUA(message: "Invalid phone format")
        ])

        // Image validation
        var photoError: String? = nil
        var imageData: Data? = nil

        if let photo = image {
            if let data = photo.jpegData(compressionQuality: 0.8) {
                imageData = data
            } else {
                photoError = "Can't process photo"
            }
        } else {
            photoError = "Photo is required"
        }

        // Overall validation status
        let isValid = [nameError, emailError, phoneError, photoError].allSatisfy { $0 == nil }

        // Return result tuple
        return (isValid, nameError, emailError, phoneError, photoError, imageData)
    }
}
