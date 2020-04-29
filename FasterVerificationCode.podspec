#
# Be sure to run `pod lib lint FasterVerificationCode.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FasterVerificationCode'
  s.version          = '0.4.1'
  s.summary          = 'An high customizable and fast verification input view.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
FasterVerificationCode is an open-source fully customizable input view built to makes easier
and faster the input of a verification code you provided via mail/phone. 
                       DESC

  s.homepage         = 'https://github.com/posix88/FasterVerificationCode'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Posix88' => 'ninomusolino@gmail.com' }
  s.source           = { :git => 'https://github.com/Posix88/FasterVerificationCode.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/NinoMusolino'
  s.swift_version = '5'
  s.ios.deployment_target = '10.0'
  
  s.source_files = 'Sources/FasterVerificationCode/**/*'
  s.resource_bundles = {
	  'FasterVerificationCode' => ['Sources/FasterVerificationCode/*.xib']
  }
  s.framework  = "UIKit"
  s.requires_arc = true
  
end
