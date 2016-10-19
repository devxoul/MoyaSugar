abstract_target 'MoyaSugar' do
  use_frameworks!

  pod 'Moya', '8.0.0-beta.2'

  target 'MoyaSugar-iOS'
  target 'MoyaSugar-macOS'
  target 'MoyaSugar-tvOS'
  target 'MoyaSugar-watchOS'

  abstract_target 'Tests' do
    pod 'Then', '~> 2.1'

    target 'MoyaSugar-iOS-Tests'
    target 'MoyaSugar-macOS-Tests'
    target 'MoyaSugar-tvOS-Tests'
  end

  abstract_target 'RxMoyaSugar' do
    pod 'Moya/RxSwift', '8.0.0-beta.2'
    pod 'RxSwift', '3.0.0-rc.1'

    target 'RxMoyaSugar-iOS'
    target 'RxMoyaSugar-macOS'
    target 'RxMoyaSugar-tvOS'
    target 'RxMoyaSugar-watchOS'
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
