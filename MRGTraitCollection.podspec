Pod::Spec.new do |s|
  s.name             = "MRGTraitCollection"
  s.version          = "0.2"
  s.summary          = "Backward compatibility layer for UITraitCollection in iOS 7."
  
  s.homepage         = "http://open.mirego.com"
  s.license          = 'BSD 3-Clause'
  s.author           = { "Mirego" => "info@mirego.com" }
  s.source           = { :git => "https://github.com/Mirego/MRGTraitCollection.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/Mirego'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  
  s.private_header_files = 'Pod/Classes/**/*_Private.h'
  s.dependency 'MAObjCRuntime', '~> 0.0'
  s.dependency 'JRSwizzle', '~> 1.0'
end
