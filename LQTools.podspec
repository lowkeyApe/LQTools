#
# Be sure to run `pod lib lint LQTools.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LQTools'
  s.version          = '1.5.5'
  s.summary          = 'Tools of lowkeyApe.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/lowkeyApe/LQTools'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '563096676@qq.com' => '563096676@qq.com' }
  s.source           = { :git => 'https://github.com/lowkeyApe/LQTools.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'LQTools/Classes/**/*'
  
    #s.resource_bundles = {
    #  'LQTools' => 'LQTools/Assets/*.png'
    # }

    s.resources  = 'LQTools/Classes/LQPhotoBrowser/MBProgressHUD.bundle','LQTools/Assets/*.png'

# s.resources = ['LQTools/Assets/*.png']

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
    s.dependency 'AFNetworking'
    s.dependency 'MBProgressHUD'
    s.dependency 'SDWebImage'


end
