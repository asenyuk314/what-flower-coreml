//
//  ImagePicker.swift
//  WhatFlower-CoreML
//
//  Created by Александр Сенюк on 13.01.2022.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
  @Binding var isShown: Bool
  @Binding var image: UIImage?
  
  func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
  }
  
  func makeCoordinator() -> ImagePickerCoordinator {
    return ImagePickerCoordinator(isShown: $isShown, image: $image)
  }
  
  func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
    let picker = UIImagePickerController()
    picker.delegate = context.coordinator
    picker.sourceType = .camera
    picker.allowsEditing = false
    return picker
  }
}
