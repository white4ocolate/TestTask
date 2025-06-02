//
//  ImagePicker.swift
//  TestTask
//

import SwiftUI
import UIKit

/// A SwiftUI-compatible wrapper around `UIImagePickerController`.
/// Allows picking an image from the photo library or camera and returns the selected `UIImage` along with its filename.
struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode

    /// The source type for picking media (photo library or camera).
    var sourceType: UIImagePickerController.SourceType = .photoLibrary

    /// Closure called after image selection.
    /// - Parameters:
    ///   - UIImage: The selected image.
    ///   - String: The image filename or a generated name if unavailable.
    var onImagePicked: (UIImage, String) -> Void

    /// Creates and configures the `UIImagePickerController` instance.
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }

    /// No need to update the view controller for our use case.
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    /// Creates a coordinator instance to bridge UIKit delegate methods.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    /// `Coordinator` handles delegate callbacks from `UIImagePickerController`.
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        /// Called when the user selects an image.
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // Attempt to get the original image
            if let image = info[.originalImage] as? UIImage {
                // Try to get the actual file name if available
                if let url = info[.imageURL] as? URL {
                    parent.onImagePicked(image, url.lastPathComponent)
                } else {
                    // Fallback: generate a filename based on timestamp
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyyMMdd_HHmmss"
                    let fileName = "photo_\(formatter.string(from: Date())).jpg"
                    parent.onImagePicked(image, fileName)
                }
            }

            // Dismiss the picker UI
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        /// Called when the user cancels the picker.
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
