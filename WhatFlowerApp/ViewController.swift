//
//  ViewController.swift
//  WhatFlowerApp
//
//  Created by Egor Lass on 18.01.2021.
//

import UIKit
import CoreML
import Vision
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
        imageView.contentMode = .scaleAspectFit
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            
            guard let ciImage = CIImage(image: userPickedImage) else {
                fatalError("Cannot convert to CIImage.")
            }
            
            detect(image: ciImage)
            
            imageView.image = userPickedImage
            imagePicker.dismiss(animated: true, completion: nil)
        }
    }
    
    func detect(image: CIImage) {
        
        guard let model = try? VNCoreMLModel(for: FlowerClassifier().model) else {
            
            fatalError("Cannot import model.")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            
            let classification = request.results?.first as? VNClassificationObservation
        
            self.navigationItem.title = classification?.identifier.capitalized
            
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
    
    @IBAction func cameraButtonPressed(_ sender: UIBarButtonItem) {
        
        present(imagePicker, animated: true, completion: nil)
    }
    
}

