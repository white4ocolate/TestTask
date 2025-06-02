//
//  SignUpView.swift
//  TestTask
//

import SwiftUI
import PhotosUI

struct SignUpView: View {
    @StateObject private var vm = SignUpViewModel()
    @FocusState private var focusedField: Field?
    @State private var showActionSheet = false
    @State private var showImagePicker = false
    @State private var showCamera = false

    // Disable the sign-up button if all fields are empty
    private var disabled: Bool {
        return vm.userName.isEmpty && vm.userEmail.isEmpty && vm.userPhone.isEmpty && (vm.userImage == nil)
    }

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            // Show loading spinner while data is loading
            if vm.isLoading {
                ProgressView()
                    .tint(.gray)
            }

            // Show loading spinner if positions list is still loading
            if vm.positions.isEmpty {
                ProgressView()
                    .tint(.gray)
            } else {
                GeometryReader { geometry in
                    ScrollView {
                        VStack {

                            Spacer()

                            // Input fields
                            VStack {
                                nameTextField
                                emailTextField
                                phoneTextField
                            }

                            Spacer()

                            // Position selection
                            VStack(spacing: 12) {
                                Text("Select your position")
                                    .typography(.body2)
                                    .foregroundStyle(Color.c_black87)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                VStack(spacing: 0) {
                                    ForEach(vm.positions) { position in
                                        HStack(spacing: 8) {
                                            // Display selection indicator (filled or empty circle)
                                            Group {
                                                if position.id == vm.positionID {
                                                    Circle()
                                                        .fill(Color.c_secondary)
                                                        .frame(width: 14)
                                                        .overlay {
                                                            Circle()
                                                                .fill(Color.white)
                                                                .frame(width: 4)
                                                        }
                                                } else {
                                                    Circle()
                                                        .stroke(Color.c_D0CFCF, lineWidth: 1)
                                                        .frame(width: 14)
                                                }
                                            }
                                            .padding(17)

                                            Text(position.name)
                                                .typography(.body1)
                                                .foregroundStyle(Color.c_black87)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .onTapGesture {
                                            vm.positionID = position.id // Update selected position
                                        }
                                    }
                                }
                            }

                            Spacer()

                            // Photo upload field
                            photoField

                            Spacer()

                            Button("Sign up") {
                                vm.signUpFlow()
                            }
                            .buttonStyle(CapsuleButtonStyle())
                            .disabled(disabled)

                            Spacer()
                        }
                        .frame(
                            maxWidth: .infinity,
                            minHeight: geometry.size.height,
                            alignment: .top
                        )
                    }
                    .scrollBounceBehavior(.basedOnSize)
                    .padding(.horizontal, 16)
                }
            }
        }
        .onAppear {
            vm.loadAllPositionsIfNeeded()   // Load positions only once
        }
        .onTapGesture {
            hideKeyboard()  // Hide keyboard when tapping outside
        }

        // Image picker option dialog
        .confirmationDialog("Choose how you want to add a photo", isPresented: $showActionSheet, titleVisibility: .visible) {
            Button("Camera") {
                vm.sourceType = .camera
                showCamera = true
            }

            Button("Gallery") {
                vm.sourceType = .photoLibrary
                showImagePicker = true
            }

            Button("Cancel", role: .cancel) {}
        }

        // Open photo picker
        .sheet(isPresented: $showImagePicker) {
            PhotoPicker { selectedImage, name in
                vm.setImage(image: selectedImage, name: name)
            }
        }

        // Open camera
        .fullScreenCover(isPresented: $showCamera) {
            ImagePicker(sourceType: .camera) { selectedImage, name in
                vm.setImage(image: selectedImage, name: name)
            }.ignoresSafeArea()
        }

        // Show result after submission
        .fullScreenCover(isPresented: $vm.isSent) {
            InformView(isSuccess: $vm.isSuccess, message: vm.errorMessage)
        }
    }
}

private extension SignUpView {
    // Name input field
    private var nameTextField: some View {
        TextFieldWithPlaceHolder(value: $vm.userName,
                                 placeholder: "Your name",
                                 bottomLabel: $vm.bottomLabelName,
                                 rules: [.required(message: "Required field")],
                                 isCorrect: $vm.isCorrectName)
        .focused($focusedField, equals: .name)
    }

    // Email input field
    private var emailTextField: some View {
        TextFieldWithPlaceHolder(value: $vm.userEmail,
                                 placeholder: "Email",
                                 bottomLabel: $vm.bottomLabelEmail,
                                 rules: [.required(message: "Required field"), .email(message: "Invalid email format")],
                                 isCorrect: $vm.isCorrectEmail)
        .focused($focusedField, equals: .email)
    }

    // Phone input field with number pad and formatting
    private var phoneTextField: some View {
        TextFieldWithPlaceHolder(value: $vm.userPhone,
                                 placeholder: "Phone",
                                 keyboardType: .numberPad, bottomLabel: vm.isCorrectPhone ? $vm.errorBottomLabelPhone : $vm.errorBottomLabelPhone,
                                 rules: [.required(message: "Required field"), .phoneUA(message: "Invalid phone format")],
                                 isCorrect: $vm.isCorrectPhone,
                                 maskType: .phoneNumber)
        .focused($focusedField, equals: .phone)
    }

    // Photo selection field with error handling
    private var photoField: some View {
        VStack(spacing: 4) {
            RoundedRectangle(cornerRadius: 4)
                .stroke(vm.isCorrectPhoto ? Color.c_D0CFCF : Color.c_Error, lineWidth: 1)
                .frame(height: 56)
                .overlay {
                    HStack {
                        Text("\(vm.photoName)")
                            .typography(.body1)
                            .foregroundStyle(vm.isCorrectPhoto ? Color.c_black48 : Color.c_Error)

                        Spacer()

                        Text("Upload")
                            .typography(.body1)
                            .foregroundStyle(Color.c_secondaryDark)
                            .padding(.trailing, 16)
                    }
                    .padding(.leading, 16)
                    .padding(.trailing, 8)
                }
                .onTapGesture {
                    showActionSheet = true  // Show camera/gallery options
                }

            // Show validation error message
            Text(!vm.isCorrectPhoto ? vm.bottomLabelPhoto : "")
                .typography(.bodySmall)
                .foregroundStyle(Color.c_Error)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
        }
    }
}

#Preview {
    SignUpView()
}
