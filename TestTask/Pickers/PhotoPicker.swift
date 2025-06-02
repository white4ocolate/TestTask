//
//  PhotoPicker.swift
//  TestTask
//

import SwiftUI
import PhotosUI

/// A wrapper around `PHPickerViewController` to use the native photo picker in SwiftUI.
/// Allows the user to select a single image and returns both the `UIImage` and its suggested filename.
struct PhotoPicker: UIViewControllerRepresentable {
    /// Closure called when an image is successfully picked.
    /// - Parameters:
    ///   - UIImage: The selected image.
    ///   - String: The suggested filename or "photo.jpg" if unavailable.
    var onImagePicked: (UIImage, String) -> Void

    /// Creates the `PHPickerViewController` instance configured to select one image.
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.selectionLimit = 1
        config.filter = .images

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    /// No need to update the view controller in this case.
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    /// Creates the `Coordinator` that will handle delegate callbacks from the picker.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    /// Coordinator class that acts as the delegate for the `PHPickerViewController`.
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: PhotoPicker

        init(_ parent: PhotoPicker) {
            self.parent = parent
        }

        /// Called when the user finishes picking an image.
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            guard let result = results.first else { return }

            // Check if the provider can load a UIImage
            if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                result.itemProvider.loadObject(ofClass: UIImage.self) { image, _ in
                    if let image = image as? UIImage {
                        DispatchQueue.main.async {
                            // Get the original filename if available
                            let name = result.itemProvider.suggestedName ?? "photo.jpg"
                            self.parent.onImagePicked(image, name)
                        }
                    }
                }
            }
        }
    }
}
