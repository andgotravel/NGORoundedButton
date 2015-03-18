Pod::Spec.new do |s|
  s.name             = "NGORoundedButton"
  s.version          = "1.0.0"
  s.description      = "A circle button for common actions. Icons are drawn in CoreGraphics."
  s.homepage         = "https://github.com/andgotravel/NGORoundedButton"
  s.license          = 'MIT'
  s.author           = { "Stas Zhukovskiy" => "stzhuk@gmail.com" }
  s.platform         = :ios, '8.0'
  s.requires_arc     = true
  s.source_files     = 'Pod/Classes/**/*'
  s.frameworks       = 'UIKit', 'CoreGraphics'
  s.source           = { :git => "https://github.com/andgotravel/NGORoundedButton.git",
                         :tag => "v#{s.version.to_s}" }
end