# WhatFlowerApp-CoreML
The App identifies a flower from a photo and provides a short description. A oxford102.caffemodel was used to analyze the photo. A Python script was written to reformat it into mlmodel. The App provides the name of the photographed flower, as well as a small description and an image from Wikipedia.

Requirements:

- iPhone 11 or newer (app uses a camera, so you can run it only on a physical device, the simulator will crash)

- iOS 12.1 or newer

- portrait orientation

Description:

In the beginning, I was going to make an application for recognizing hotdogs in a photo (yes, the same as the "seafood" in the Silicon Valley TV series, but it turned out that it could be easily converted into an app for recognizing any objects from a photo. The "SqueezeNet" mlmodel was used.

Used Swift capabilities:

- CoreML

- Vision framework

- CocoaPods: Alamofire, SwiftyJSON, SDWebImage

- Http requests

- Parsing the JSON format


