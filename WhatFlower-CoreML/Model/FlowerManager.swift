//
//  FlowerManager.swift
//  WhatFlower-CoreML
//
//  Created by Александр Сенюк on 13.01.2022.
//

import SwiftUI
import CoreML
import Vision
import Alamofire
import SwiftyJSON

class FlowerManager: ObservableObject {
  private let wikipediaURl = "https://en.wikipedia.org/w/api.php"
  private var image: UIImage?
  @Published var flowerName: String?
  @Published var flowerDescription: String?
  @Published var flowerImageURL: String?
  
  func detect(flowerImage: UIImage) {
    if let CiFlowerImage = CIImage(image: flowerImage) {
      guard let model = try? VNCoreMLModel(for: FlowerClassifier(configuration: MLModelConfiguration()).model) else {
        fatalError("Cannot import model")
      }
      
      let request = VNCoreMLRequest(model: model) { request, error in
        guard let classification = request.results?.first as? VNClassificationObservation else {
          fatalError("Cannot classify image")
        }
        self.flowerName = classification.identifier.capitalized
        self.requestInfo(flowerName: classification.identifier)
      }
      
      let handler = VNImageRequestHandler(ciImage: CiFlowerImage)
      do {
        try handler.perform([request])
      } catch {
        print("Cannot perform model request: \(error)")
      }
    }
  }
  
  private func requestInfo(flowerName: String) {
    let parameters: [String:String] = [
      "format": "json",
      "action": "query",
      "prop": "extracts|pageimages",
      "exintro": "",
      "explaintext": "",
      "titles": flowerName,
      "indexpageids": "",
      "redirects": "1",
      "pithumbsize": "500"
    ]
    AF.request(wikipediaURl, method: .get, parameters: parameters).validate().responseJSON { response in
      switch response.result {
      case .success(let value):
        let flowerJSON: JSON = JSON(value)
        let pageId = flowerJSON["query"]["pageids"][0].stringValue
        self.flowerDescription = flowerJSON["query"]["pages"][pageId]["extract"].stringValue
        self.flowerImageURL = flowerJSON["query"]["pages"][pageId]["thumbnail"]["source"].stringValue
      case .failure(let error):
        print("Cannot perform api request: \(error)")
      }
    }
  }
}
