Pod::Spec.new do |s|
  s.name        = "MoyaSugar"
  s.version     = "0.1.0"
  s.summary     = "Syntactic sugar for Moya."
  s.homepage    = "https://github.com/devxoul/MoyaSugar"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "Suyeol Jeon" => "devxoul@gmail.com" }
  s.source           = { :git => "https://github.com/devxoul/MoyaSugar.git",
                         :tag => s.version.to_s }
  s.source_files     = "Sources/*.swift", "Sources/RxSwift/*.swift"
  s.requires_arc     = true

  s.dependency 'Moya', '= 8.0.0-beta.3'
  s.dependency 'Moya/RxSwift', '= 8.0.0-beta.3'
  s.dependency 'RxSwift', '= 3.0.0-rc.1'

  s.ios.deployment_target = "9.0"
  s.osx.deployment_target = "10.9"
  s.tvos.deployment_target = "9.0"
  s.watchos.deployment_target = "3.0"
end
