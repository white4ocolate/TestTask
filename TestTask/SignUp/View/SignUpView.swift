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
    private var disabled: Bool {
        return vm.name.isEmpty && vm.email.isEmpty && vm.phone.isEmpty && (vm.image == nil)
    }

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            if vm.isLoading {
                ProgressView()
                    .tint(.gray)
            }

            if vm.positions.isEmpty {
                ProgressView()
                    .tint(.gray)
            } else {
                GeometryReader { geometry in
                    ScrollView {
                        VStack {

                            Spacer()

                            VStack {
                                nameTextField

                                emailTextField

                                phoneTextField
                            }

                            Spacer()

                            VStack(spacing: 12) {
                                Text("Select your position")
                                    .typography(.body2)
                                    .foregroundStyle(Color.c_black87)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                VStack(spacing: 0) {
                                    ForEach(vm.positions) { position in
                                        HStack(spacing: 8) {
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
                                            vm.positionID = position.id
                                        }
                                    }
                                }
                            }

                            Spacer()

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
            vm.loadAllPositionsIfNeeded()
        }
        .onTapGesture {
            hideKeyboard()
        }
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
        .sheet(isPresented: $showImagePicker) {
            PhotoPicker { selectedImage, name in
                vm.setImage(image: selectedImage, name: name)
            }
        }
        .fullScreenCover(isPresented: $showCamera) {
            ImagePicker(sourceType: .camera) { selectedImage, name in
                vm.setImage(image: selectedImage, name: name)
            }.ignoresSafeArea()
        }
        .fullScreenCover(isPresented: $vm.isSent) {
            InformView(isSuccess: $vm.isSuccess, message: vm.errorMessage)
        }
    }
}

private extension SignUpView {
    private var nameTextField: some View {
        TextFieldWithPlaceHolder(value: $vm.name,
                                 placeholder: "Your name",
                                 bottomLabel: $vm.bottomLabelName,
                                 rules: [.required(message: "Required field")],
                                 isCorrect: $vm.isCorrectName)
        .focused($focusedField, equals: .name)
    }

    private var emailTextField: some View {
        TextFieldWithPlaceHolder(value: $vm.email,
                                 placeholder: "Email",
                                 bottomLabel: $vm.bottomLabelEmail,
                                 rules: [.required(message: "Required field"), .email(message: "Invalid email format")],
                                 isCorrect: $vm.isCorrectEmail)
        .focused($focusedField, equals: .email)
    }

    private var phoneTextField: some View {
        TextFieldWithPlaceHolder(value: $vm.phone,
                                 placeholder: "Phone",
                                 keyboardType: .numberPad, bottomLabel: vm.isCorrectPhone ? $vm.errorBottomLabelPhone : $vm.errorBottomLabelPhone,
                                 rules: [.required(message: "Required field"), .phoneUA(message: "Invalid phone format")],
                                 isCorrect: $vm.isCorrectPhone,
                                 maskType: .phoneNumber)
        .focused($focusedField, equals: .phone)
    }

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
                    showActionSheet = true
                }

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
