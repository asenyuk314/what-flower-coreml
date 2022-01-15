//
//  ContentView.swift
//  WhatFlower-CoreML
//
//  Created by Александр Сенюк on 13.01.2022.
//

import SwiftUI

struct ContentView: View {
  @State private var showImagePicker: Bool = false
  @State private var image: UIImage?
  
  var body: some View {
    VStack {
      FlowerView(image: image)
      Spacer()
      Button {
        showImagePicker.toggle()
      } label: {
        Label("Take a photo", systemImage: "camera")
      }
      .padding()
    }.sheet(isPresented: $showImagePicker) {
      ImagePicker(isShown: $showImagePicker, image: $image)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
