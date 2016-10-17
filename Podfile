platform :ios, '9.0'

abstract_target 'MoyaSugar' do
  use_frameworks!

  pod 'Moya', '8.0.0-beta.2'

  target 'MoyaSugar-iOS'
  target 'MoyaSugar-macOS'
  target 'MoyaSugar-tvOS'
  target 'MoyaSugar-watchOS'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
