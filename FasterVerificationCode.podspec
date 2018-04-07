#
# Be sure to run `pod lib lint FasterVerificationCode.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FasterVerificationCode'
  s.version          = '0.1.0'
  s.summary          = 'An high customizable and fast verification code view.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
FasterVerificationCode is a fully customizable verification code input view.
It makes easy to your user to insert the verification code you provided via mail/phone.
It supports the paste action
                       DESC

  s.homepage         = 'https://github.com/posix88/FasterVerificationCode'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Posix88' => 'ninomusolino@gmail.com' }
  s.source           = { :git => 'https://github.com/Posix88/FasterVerificationCode.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/NinoMusolino'

  s.ios.deployment_target = '10.0'

  s.source_files = 'FasterVerificationCode/Classes/**/*'
  s.resource_bundles = {
	  'FasterVerificationCode' => ['FasterVerificationCode/Classes/*.xib']
  }
  s.framework  = "UIKit"
  s.requires_arc = true
  
end
