//
//  ViewController.swift
//  WhatFlowerApp
//
//  Created by Egor Lass on 18.01.2021.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var imagePicker : UIImagePickerController = {
        let uiipc = UIImagePickerController()
        uiipc.delegate = self
        uiipc.allowsEditing = false
        uiipc.sourceType = .camera
        return uiipc
    }()
    lazy var detection : Detection = {
        let dtct = Detection()
        dtct.delegate = self
        return dtct
    }()
    @IBOutlet private weak var hintLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!{
        didSet{
            imageView.contentMode = .scaleAspectFill
        }
    }
    @IBOutlet private weak var labelFlowerInfo: UILabel!
    
    @IBAction func cameraButtonPressed(_ sender: UIBarButtonItem) {
        hintLabel?.removeFromSuperview()
        present(imagePicker, animated: true, completion: nil)
    }
}

extension ViewController:  DetectionDelegate {
    func detectionDidEnd(_ sender: Detection, _ identifier: String) {
        self.navigationItem.title = identifier.capitalized
        detection.requestInfo(flowerName: identifier)
    }
    func responseDidSuccess(_ sender: Detection, _ flowerInfo: String, _ flowerImageURL: String) {
        self.imageView.sd_setImage(with: URL(string: flowerImageURL))
        self.labelFlowerInfo.text = flowerInfo
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            guard let ciImage = CIImage(image: userPickedImage) else
            {
                fatalError("Cannot convert to CIImage.")
            }
            detection.detect(image: ciImage)
            imagePicker.dismiss(animated: true, completion: nil)
        }
    }
}
