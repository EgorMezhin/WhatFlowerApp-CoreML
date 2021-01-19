# Uncomment the next line to define a global platform for your project
platform :ios, '14.2'

target 'WhatFlowerApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for WhatFlowerApp
  
pod 'Alamofire', '~> 4.4'
pod 'SwiftyJSON'
pod 'SDWebImage'

post_install do |installer|
 installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
  end
 end
end

end
