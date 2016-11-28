# Uncomment this line to define a global platform for your project
source 'https://git.coding.net/lijy91/Specs.git'
platform :ios, '9.0'

target 'Daza' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Daza
  pod 'MJRefresh'
  pod 'Alamofire', '~> 3.5.0'
  pod 'ObjectMapper', '~> 1.3'
  pod 'AlamofireObjectMapper', '~> 3.0'
  # pod 'RealmSwift'
  pod 'SDWebImage', '~> 3.8.2'
  pod 'SnapKit', '~> 0.22.0'
  pod 'NJKWebViewProgress'
  pod 'SVProgressHUD'
  pod '1PasswordExtension', '~> 1.8.2'
  pod 'JVFloatLabeledTextField'
  pod 'DZNEmptyDataSet'
  pod 'Eureka', '~> 1.7.0'
  pod 'XLPagerTabStrip', '~> 5.0'
  pod 'DateTools'
  pod 'GrowingIO'
  pod 'TUSafariActivity', '~> 1.0'
  pod 'WZLBadge'
  pod 'KSCrash', '~> 1.8'
#  pod 'Reveal-iOS-SDK', :configurations => ['Debug']

  target 'DazaTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'DazaUITests' do
    inherit! :search_paths
    # Pods for testing
  end

  post_install do |installer|
      installer.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['SWIFT_VERSION'] = '2.3'
          end
      end
  end

end
