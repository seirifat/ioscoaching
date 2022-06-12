# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'
inhibit_all_warnings!

target 'iOSCoach' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for iOSCoach
  pod 'Alamofire', '~> 5.5'
  pod 'AlamofireImage', '~> 4.1'
  pod 'RealmSwift'
  pod 'SVPullToRefresh'

  target 'iOSCoachTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'iOSCoachUITests' do
    # Pods for testing
  end

end

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      end
    end
end
