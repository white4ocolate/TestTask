//
//  FormValidator.swift
//  TestTask
//

import SwiftUI

struct FormValidator {
    static func validate(name: String, email: String, phone: String, image: UIImage?) -> (
        isValid: Bool,
        nameError: String?,
        emailError: String?,
        phoneError: String?,
        photoError: String?,
        imageData: Data?
    ) {
        let nameError = FieldValidator.validate(name, rules: [
            .moreCharacter(message: "Your should be 2-60 characters"),
            .required(message: "Required field")
        ])

        let emailError = FieldValidator.validate(email, rules: [
            .required(message: "Required field"),
            .email(message: "Invalid email format")
        ])

        let phoneError = FieldValidator.validate(phone, rules: [
            .required(message: "Required field"),
            .phoneUA(message: "Invalid phone format")
        ])

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

        let isValid = [nameError, emailError, phoneError, photoError].allSatisfy { $0 == nil }

        return (isValid, nameError, emailError, phoneError, photoError, imageData)
    }
}
