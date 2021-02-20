
# WhatFlowerApp-CoreML

**App testing conditions:**
-----------------------------------
- iPhone 11
- iOS 14.2
- portrait orientation

Important: 
1. App not working on Xcode simulator due to camera use, you need a physical device.
2. The app uses a machine learning model I created. due to its large size I had to use git LFS. Therefore, after downloading the repository, do not forget to additionally download the model. Commands 'git lfs fetch' and 'git lfs pull' are working for me. 
 
**Description:**
-----------------------------------
The App identifies a flower from a photo and provides a short description. A oxford102.caffemodel was used to analyze the photo. A Python script was written to reformat it into mlmodel. The App provides the name of the photographed flower, as well as a small description and an image from Wikipedia.

**App features:**
-----------------------------------
- CoreML
- Vision
- Alamofire
- SwiftyJSON
- SDWebImage
- ImagePickerController

