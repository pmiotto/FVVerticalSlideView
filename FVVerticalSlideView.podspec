Pod::Spec.new do |s|
  s.name             = "FVVerticalSlideView"
  s.version          = "0.1"
  s.summary          = "Easy and simple vertical slider where you can add your custom subviews."
  s.homepage         = "https://github.com/tato469/FVVerticalSlideView"
  s.license          = 'MIT'
  s.author           = { "tato469" => "fernandovalle.developer@gmail.com" }
  s.source           = { :git => "https://github.com/tato469/FVVerticalSlideView.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/tato469'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'resources/*.{m,h}'
  s.frameworks = 'UIKit'
end
