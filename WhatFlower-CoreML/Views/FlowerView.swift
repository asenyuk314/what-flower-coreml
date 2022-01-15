//
//  FlowerView.swift
//  WhatFlower-CoreML
//
//  Created by Александр Сенюк on 13.01.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct FlowerView: View {
  private var image: UIImage?
  @ObservedObject private var flowerManager = FlowerManager()
  
  init(image: UIImage?) {
    self.image = image
    self.detectFlower()
  }
  
  var body: some View {
    VStack {
      if let safeFlowerName = flowerManager.flowerName {
        Text(safeFlowerName)
          .padding()
          .font(.title3)
      }
      Spacer()
      if let safeImageUrl = flowerManager.flowerImageURL {
        WebImage(url: URL(string: safeImageUrl))
          .placeholder(Image(systemName: "camera.badge.ellipsis"))
          .resizable()
          .scaledToFit()
      }
      Spacer()
      if let safeDescription = flowerManager.flowerDescription {
        ScrollView {
          Text(safeDescription)
            .padding()
        }
      }
    }
  }
  
  private func detectFlower() {
    if let safeImage = image {
      flowerManager.detect(flowerImage: safeImage)
    }
  }
}

struct FlowerView_Previews: PreviewProvider {
  static var previews: some View {
    FlowerView(image: UIImage())
  }
}
