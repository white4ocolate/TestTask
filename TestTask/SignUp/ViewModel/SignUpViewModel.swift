//
//  SignUpViewModel.swift
//  TestTask
//

import SwiftUI

@MainActor
class SignUpViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var isSignedUp = false
    @Published var positions: [Position] = []
    @Published var positionID = 1
    @Published var name = ""
    @Published var email = ""
    @Published var phone = ""
    @Published var image: UIImage?
    @Published var photoName = "Upload your photo"
    @Published var sourceType: UIImagePickerController.SourceType = .photoLibrary

    // Validation
    @Published var isCorrectName = true
    @Published var isCorrectEmail = true
    @Published var isCorrectPhone = true
    @Published var isCorrectPhoto = true

    @Published var bottomLabelName: String? = nil
    @Published var bottomLabelEmail: String? = nil
    @Published var errorBottomLabelPhone: String? = nil
    @Published var bottomLabelPhoto: String = "Photo is required"

    // Sign-up result
    @Published var isSent = false
    @Published var isSuccess = false
    @Published var errorMessage = "That email is already registered"

    private let service = SignUpService()
    private var imageData: Data?

    func setImage(image: UIImage, name: String) {
        self.image = image
        self.photoName = name
        isCorrectPhoto = true
    }

    func loadAllPositionsIfNeeded() {
        guard positions.isEmpty else { return }
        Task {
            isLoading = true
            positions = await service.loadAllPositions()
            isLoading = false
        }
    }

    func signUpFlow() {
        Task {
            isLoading = true
            let result = FormValidator.validate(name: name, email: email, phone: phone, image: image)
            bottomLabelName = result.nameError
            bottomLabelEmail = result.emailError
            errorBottomLabelPhone = result.phoneError
            bottomLabelPhoto = result.photoError ?? "Photo is required"

            isCorrectName = result.nameError == nil
            isCorrectEmail = result.emailError == nil
            isCorrectPhone = result.phoneError == nil
            isCorrectPhoto = result.photoError == nil
            imageData = result.imageData

            guard result.isValid, let imageData = imageData else {
                isLoading = false
                return
            }

            guard let token = await service.getToken() else {
                errorMessage = "Can't get token"
                isSent = true
                isSuccess = false
                isLoading = false
                return
            }

            do {
                let success = try await service.signUp(
                    name: name,
                    email: email,
                    phone: phone,
                    positionID: positionID,
                    photoName: photoName,
                    imageData: imageData,
                    token: token
                )
                isSuccess = success
            } catch {
                isSuccess = false
                errorMessage = error.localizedDescription
            }

            isSent = true
            isLoading = false
        }
    }
}
