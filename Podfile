# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
      end
    end
end

target 'Homework' do

  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Homework
  pod 'Alamofire', '~> 5.2'
  pod 'SwiftyJSON', '~> 4.0'
  pod 'Kingfisher', '~> 5.0'

end
