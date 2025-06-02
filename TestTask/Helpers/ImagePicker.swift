//
//  ImagePicker.swift
//  TestTask
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    var onImagePicked: (UIImage, String) -> Void

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
             if let image = info[.originalImage] as? UIImage {
                 if let url = info[.imageURL] as? URL {
                     parent.onImagePicked(image, url.lastPathComponent)
                 } else {
                     let formatter = DateFormatter()
                     formatter.dateFormat = "yyyyMMdd_HHmmss"
                     let fileName = "photo_\(formatter.string(from: Date())).jpg"
                     parent.onImagePicked(image, fileName)
                 }
             }
             parent.presentationMode.wrappedValue.dismiss()
         }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
