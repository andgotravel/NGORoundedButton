Pod::Spec.new do |s|
  s.name             = "NGORoundedButton"
  s.version          = "2.4"
  s.summary          = "A custom UIButton for common actions. Icons are drawn in CoreGraphics. No Images."
  s.homepage         = "https://github.com/andgotravel/NGORoundedButton"
  s.license          = 'MIT'
  s.author           = { "Stas Zhukovskiy" => "stzhuk@gmail.com" }
  s.source           = { :git => "https://github.com/andgotravel/NGORoundedButton.git", :tag => s.version.to_s }
  s.platform     	 = :ios, '7.0'
  s.requires_arc 	 = true
  s.source_files 	 = 'Pod/Classes/**/*'
  s.frameworks       = 'UIKit', 'CoreGraphics'
end
