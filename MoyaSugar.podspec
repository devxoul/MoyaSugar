Pod::Spec.new do |s|
  s.name             = 'MoyaSugar'
  s.version          = '1.3.2'
  s.summary          = '🍯 Syntactic sugar for Moya'
  s.homepage         = 'https://github.com/devxoul/MoyaSugar'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Suyeol Jeon' => 'devxoul@gmail.com' }
  s.source           = { :git => 'https://github.com/devxoul/MoyaSugar.git',
                         :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '3.0'

  s.default_subspec = 'Core'
  s.swift_version = '5.1'

  s.subspec 'Core' do |ss|
    ss.source_files = 'Sources/MoyaSugar/*.swift'
    ss.frameworks   = 'Foundation'
    ss.dependency 'Moya', '>= 14.0.0-beta.2'
  end

  s.subspec 'RxSwift' do |ss|
    ss.dependency 'MoyaSugar/Core'
    ss.dependency 'Moya/RxSwift', '>= 14.0.0-beta.2'
    ss.dependency 'RxSwift', '>= 5.0.0'
  end
end
