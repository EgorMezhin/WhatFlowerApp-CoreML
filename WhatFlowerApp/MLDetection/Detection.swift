//
//  Detection.swift
//  WhatFlowerApp
//
//  Created by Egor Lass on 20.02.2021.
//

import UIKit
import Vision
import CoreML
import Alamofire
import SwiftyJSON
import SDWebImage

protocol DetectionDelegate: class {
    func detectionDidEnd(_ sender: Detection, _ identifier: String)
    func responseDidSuccess(_ sender: Detection, _ flowerInfo: String, _ flowerImageURL: String)
}

class Detection {
    
    weak var delegate : DetectionDelegate?
    
    //MARK: - ML Detection
    func detect(image: CIImage) {
        var identifier = String()
        guard let model = try? VNCoreMLModel(for: FlowerClassifier(configuration: MLModelConfiguration()).model) else {
            fatalError("Cannot import model.")
        }
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let classification = request.results?.first as? VNClassificationObservation else {
                fatalError("Could not classify image.")
            }
            identifier = classification.identifier
        }
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
        self.delegate?.detectionDidEnd(self, identifier)
    }
    
    //MARK: - Wiki request for detected flower type
    func requestInfo(flowerName: String) {
        let parameters : [String:String] = [
            "format" : "json",
            "action" : "query",
            "prop" : "extracts|pageimages",
            "exintro" : "",
            "explaintext" : "",
            "titles" : flowerName,
            "indexpageids" : "",
            "redirects" : "1",
            "pithumbsize" : "500"
        ]
        Alamofire.request(Constants.wikipediaURl, method: .get, parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess {
                let flowerJSON: JSON = JSON(response.result.value!)
                let pageId = flowerJSON["query"]["pageids"][0].stringValue
                let flowerInfo = flowerJSON["query"]["pages"][pageId]["extract"].stringValue
                let flowerImageURL = flowerJSON["query"]["pages"][pageId]["thumbnail"]["source"].stringValue
                self.delegate?.responseDidSuccess(self, flowerInfo, flowerImageURL)
            }
        }
    }
}

extension Detection {
    private struct Constants {
        static let wikipediaURl = "https://en.wikipedia.org/w/api.php"
    }
}
