//
//  TextFieldWithPlaceHolder.swift
//  TestTask
//

import SwiftUI

enum MaskType {
    case phoneNumber
}

/// A custom text field with floating placeholder, validation, and optional phone mask.
struct TextFieldWithPlaceHolder: View {
    @Binding var value: String
    var placeholder: String
    var keyboardType: UIKeyboardType = .default
    var autocorrectionDisabled: Bool = true
    var textInputAutocapitalization: TextInputAutocapitalization = .never
    @Binding var bottomLabel: String?
    var rules: [ValidationRule]
    @FocusState private var isFocused: Bool
    @Binding var isCorrect: Bool
    var maskType: MaskType? = nil
    @State private var displayText: String = ""
    @State private var wasEverFocused: Bool = false

    var currentState: TextFieldState {
        if !isCorrect {
            return value.isEmpty ? .error : .errorFilled
        } else if isFocused {
            return value.isEmpty ? .focused : .focusedFilled
        } else {
            return value.isEmpty ? .enabled : .enabledFilled
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ZStack {
                // Background and border rectangle
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.white)
                    .frame(height: 56)
                    .overlay {
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(currentState.borderColor)
                    }

                // Floating placeholder text
                Text(placeholder)
                    .foregroundStyle(currentState.placeHolderColor)
                    .typography(isFocused || !value.isEmpty ? .bodySmall : .body1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
                    .offset(y: isFocused || !value.isEmpty ? -15 : 0)
                    .animation(.linear(duration: 0.1), value: isFocused || !value.isEmpty)

                // If using a phone number mask
                if let maskType = maskType {
                    switch maskType {
                    case .phoneNumber:
                        TextField("", text: $displayText)
                            .foregroundColor(Color.c_black87)
                            .typography(.body1)
                            .keyboardType(.numberPad)
                            .autocorrectionDisabled(autocorrectionDisabled)
                            .textInputAutocapitalization(textInputAutocapitalization)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 4)
                            .frame(height: 56)
                            .offset(y: 5)
                            .focused($isFocused)
                            .onChange(of: isFocused) { oldFocus, newFocus in
                                if newFocus {
                                    // On first focus, insert country prefix
                                    if !wasEverFocused {
                                        wasEverFocused = true
                                    }

                                    if displayText.isEmpty {
                                        displayText = "+38 (0"
                                    }
                                } else {
                                    // If unfocused and field is still in initial state, reset
                                    if displayText.hasPrefix("+38 (0") && value.isEmpty {
                                        displayText = ""
                                        value = ""
                                    }
                                }
                            }
                            .onChange(of: displayText) { oldValue, newValue in
                                // Handle live phone formatting and keep raw digits in `value`
                                if newValue.isEmpty || newValue == "+38 (0" {
                                    if newValue.isEmpty && wasEverFocused && isFocused {
                                        DispatchQueue.main.async {
                                            displayText = ""
                                        }
                                    }
                                    value = ""
                                    return
                                }
                                if newValue.hasPrefix("+38") {
                                    let inputNumbers = newValue.dropFirst(3).filter { $0.isNumber }
                                    value = String(inputNumbers)
                                    displayText = formatPhoneNumber(inputNumbers)
                                } else {
                                    if let lastChar = newValue.last, lastChar.isNumber {
                                        let newDigit = String(lastChar)
                                        value += newDigit
                                        displayText = formatPhoneNumber(value)
                                    } else {
                                        displayText = formatPhoneNumber(value)
                                    }
                                }
                            }
                    }
                } else {
                    // Default text field without a mask
                    TextField("", text: $value)
                        .foregroundColor(Color.c_black87)
                        .typography(.body1)
                        .keyboardType(keyboardType)
                        .autocorrectionDisabled(autocorrectionDisabled)
                        .textInputAutocapitalization(textInputAutocapitalization)
                        .padding(.leading, 16)
                        .padding(.vertical, 4)
                        .frame(height: 56)
                        .offset(y: 5)
                        .focused($isFocused)
                }
            }
            // Bottom label (for error message or helper text)
            Text(bottomLabel ?? "")
                .typography(.bodySmall)
                .foregroundStyle( !isCorrect ? Color.c_Error : Color.c_black60)
                .padding(.horizontal, 16)
        }
        .onAppear {
            // Format text on appear if it's already set (e.g., editing existing user)
            if !value.isEmpty && maskType == .phoneNumber {
                displayText = formatPhoneNumber(value)
            }
        }
    }

    // Formats a phone number in the format "+38 (XXX) XXX - XX - XX"
    private func formatPhoneNumber(_ value: String) -> String {
        var numbers = String(value).filter { $0.isNumber }

        // Ensure number starts with 0
        if !numbers.hasPrefix("0") {
            numbers = "0" + numbers
        }

        let maxDigits = 10
        let limited = String(numbers.prefix(maxDigits))

        var result = "+38 ("

        if !limited.isEmpty {
            result += limited.prefix(3)
            result += limited.count > 3 ? ") " : ""
        }

        if limited.count > 3 {
            let index3 = limited.index(limited.startIndex, offsetBy: 3)
            let index6 = limited.index(limited.startIndex, offsetBy: min(6, limited.count))
            result += String(limited[index3..<index6])
        }

        if limited.count > 6 {
            result += " - "
            let index6 = limited.index(limited.startIndex, offsetBy: 6)
            let index8 = limited.index(limited.startIndex, offsetBy: min(8, limited.count))
            result += String(limited[index6..<index8])
        }

        if limited.count > 8 {
            result += " - "
            let index8 = limited.index(limited.startIndex, offsetBy: 8)
            let index10 = limited.index(limited.startIndex, offsetBy: min(10, limited.count))
            result += String(limited[index8..<index10])
        }
        return result
    }
}

#Preview {
    SignUpView()
}
