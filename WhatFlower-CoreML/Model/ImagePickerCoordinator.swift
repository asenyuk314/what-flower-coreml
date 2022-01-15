//
//  ImagePickerCoordinator.swift
//  WhatFlower-CoreML
//
//  Created by Александр Сенюк on 13.01.2022.
//

import SwiftUI

class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  @Binding var isShown: Bool
  @Binding var image: UIImage?
  
  init(isShown: Binding<Bool>, image: Binding<UIImage?>) {
    self._isShown = isShown
    self._image = image
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    image = info[.originalImage] as? UIImage
    isShown = false
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    isShown = false
  }
}
