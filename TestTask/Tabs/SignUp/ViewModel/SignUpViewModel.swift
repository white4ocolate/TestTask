//
//  SignUpViewModel.swift
//  TestTask
//

import SwiftUI

@MainActor
class SignUpViewModel: ObservableObject {
    // MARK: - UI State

    /// Indicates if a loading indicator should be shown
    @Published var isLoading = false

    /// Flag indicating whether the user has successfully signed up
    @Published var isSignedUp = false

    /// List of available positions fetched from the server
    @Published var positions: [Position] = []

    /// Currently selected position ID
    @Published var positionID = 1

    /// User input for name, email, phone, and photo
    @Published var userName = ""
    @Published var userEmail = ""
    @Published var userPhone = ""
    @Published var userImage: UIImage?

    /// Displayed photo name (e.g., file name or placeholder)
    @Published var photoName = "Upload your photo"

    /// Source for picking an image (camera or photo library)
    @Published var sourceType: UIImagePickerController.SourceType = .photoLibrary

    // MARK: - Validation State

    /// Validation
    @Published var isCorrectName = true
    @Published var isCorrectEmail = true
    @Published var isCorrectPhone = true
    @Published var isCorrectPhoto = true

    /// Error messages shown below each input field
    @Published var bottomLabelName: String? = nil
    @Published var bottomLabelEmail: String? = nil
    @Published var errorBottomLabelPhone: String? = nil
    @Published var bottomLabelPhoto: String = "Photo is required"

    // MARK: - Submission Result

    /// Indicates if the form has been submitted
    @Published var isSent = false

    /// Indicates if the submission was successful
    @Published var isSuccess = false

    /// Error message shown in case of failure
    @Published var errorMessage = "That email is already registered"

    // MARK: - Internal State

    private let service = SignUpService()
    private var imageData: Data?

    // MARK: - Public Methods

    /// Sets the user-selected image and updates the photo name
    func setImage(image: UIImage, name: String) {
        self.userImage = image
        self.photoName = name
        isCorrectPhoto = true
    }

    /// Loads available positions from API if not already fetched
    func loadAllPositionsIfNeeded() {
        guard positions.isEmpty else { return }
        Task {
            isLoading = true
            positions = await service.loadAllPositions()
            isLoading = false
        }
    }

    /// Performs full sign-up flow including validation, token fetching, and form submission
    func signUpFlow() {
        Task {
            isLoading = true

            // Validate user input and prepare image data
            let result = FormValidator.validate(name: userName, email: userEmail, phone: userPhone, image: userImage)

            // Show validation errors in UI
            bottomLabelName = result.nameError
            bottomLabelEmail = result.emailError
            errorBottomLabelPhone = result.phoneError
            bottomLabelPhoto = result.photoError ?? "Photo is required"

            // Set visual flags for validation
            isCorrectName = result.nameError == nil
            isCorrectEmail = result.emailError == nil
            isCorrectPhone = result.phoneError == nil
            isCorrectPhoto = result.photoError == nil
            imageData = result.imageData

            // Exit if validation failed
            guard result.isValid, let imageData = imageData else {
                isLoading = false
                return
            }

            // Try to get auth token
            guard let token = await service.getToken() else {
                errorMessage = "Can't get token"
                isSent = true
                isSuccess = false
                isLoading = false
                return
            }

            // Submit the sign-up form
            do {
                let success = try await service.signUp(
                    name: userName,
                    email: userEmail,
                    phone: userPhone,
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
