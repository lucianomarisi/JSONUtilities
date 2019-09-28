Pod::Spec.new do |spec|
  spec.name         = 'JSONUtilities'
  spec.homepage     = 'https://github.com/lucianomarisi/JSONUtilities'
  spec.version      = '6.0.0'
  spec.license      = { :type => 'MIT' }
  spec.authors      = { 'Luciano Marisi' => 'luciano@techbrewers.com' }
  spec.summary      = 'Easily load JSON objects and decode them into structs or classes'
  spec.source           = {
    :git => "https://github.com/lucianomarisi/JSONUtilities.git",
    :tag => spec.version.to_s
  }
  spec.source_files = 'Sources/**/*.swift'
  spec.swift_versions = ['5.0']
  spec.ios.deployment_target = '8.0'
  spec.tvos.deployment_target = '9.0'
  spec.osx.deployment_target = '10.10'
  spec.watchos.deployment_target = '2.0'
end

