Pod::Spec.new do |s|
  s.name             = 'MoyaSugar'
  s.version          = '0.4.1'
  s.summary          = '🍯 Syntactic sugar for Moya'
  s.homepage         = 'https://github.com/devxoul/MoyaSugar'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Suyeol Jeon' => 'devxoul@gmail.com' }
  s.source           = { :git => 'https://github.com/devxoul/MoyaSugar.git',
                         :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.11'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.pod_target_xcconfig = {
    'SWIFT_VERSION' => '3.1'
  }
  s.default_subspec = 'Core'

  s.subspec 'Core' do |ss|
    ss.source_files = 'Sources/MoyaSugar/*.swift'
    ss.frameworks   = 'Foundation'
    ss.dependency 'Moya', '>= 9.0.0'
  end

  s.subspec 'RxSwift' do |ss|
    ss.dependency 'MoyaSugar/Core'
    ss.dependency 'Moya/RxSwift', '>= 9.0.0'
    ss.dependency 'RxSwift', '>= 3.0.0'
  end
end
