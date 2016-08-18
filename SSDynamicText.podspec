Pod::Spec.new do |s|
  s.name           = 'SSDynamicText'
  s.version        = '1.0.0'
  s.summary        = "UILabel/UIButton/UITextField/UITextView subclasses that support custom fonts with iOS 7's dynamic text sizes."
  s.homepage       = 'https://github.com/splinesoft/SSDynamicText'
  s.license        = { type: 'MIT', file: 'LICENSE' }
  s.author         = { 'Jonathan Hersh' => 'jon@her.sh' }
  s.source         = { git: 'https://github.com/splinesoft/SSDynamicText.git', tag: s.version.to_s }
  s.requires_arc   = true
  s.compiler_flags = '-fmodules'
  s.source_files   = 'Pod/Classes/**/*.{h,m}'
  s.frameworks     = 'UIKit'
  s.ios.deployment_target = '7.0'
  s.social_media_url = 'https://twitter.com/jhersh'
end
