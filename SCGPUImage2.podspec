#
# Be sure to run `pod lib lint SCGPUImage2.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SCGPUImage2'
  s.version          = '0.1.2'
  s.summary          = '1.修改camera支持切换摄像头,2修改renderview支持横竖屏切换'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/SCFighting/SCGPUImage2'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '孙超' => 'hyswcvip@163.com' }
  s.source           = { :git => 'git@github.com:SCFighting/SCGPUImage2.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'
  s.swift_versions = '5.0'
  s.source_files = 'SCGPUImage2/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SCGPUImage2' => ['SCGPUImage2/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'OpenGLES', 'CoreMedia', 'QuartzCore', 'AVFoundation'
  # s.dependency 'AFNetworking', '~> 2.3'
end
