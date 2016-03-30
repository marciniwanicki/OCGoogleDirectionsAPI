Pod::Spec.new do |s|
  s.name             = "OCGoogleDirectionsAPI"
  s.version          = "0.1.6"
  s.summary          = "A lightweight wrapper for The Google Directions API."
  s.homepage         = "https://github.com/marciniwanicki/OCGoogleDirectionsAPI"
  s.license          = 'MIT'
  s.author           = { "Marcin Iwanicki" => "marcin.iwanicki@appliwings.com" }
  s.source           = { :git => "https://github.com/marciniwanicki/OCGoogleDirectionsAPI.git", :tag => "#{s.version}" }

  s.ios.deployment_target = '7.0'
  s.requires_arc = true

  s.source_files = 'Source/OCGoogleDirectionsAPI/**/*.{h,m}'
  s.public_header_files = 'Source/OCGoogleDirectionsAPI/**/*.h'

  s.frameworks = 'CoreLocation'
end
