Pod::Spec.new do |s|
  s.name         = "YolandaFramework"
  s.version      = "0.0.1"
  s.summary      = "YolandaFramework"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage     = "https://github.com/tn173/YolandaFramework"
  s.author       = { "tn173" => "tomoaki.nishioka@upswell.jp" }
  s.source       = { :git => "https://github.com/tn173/YolandaFramework.git", :tag => "#{s.version}" }
  s.platform     = :ios, '8.0'
  s.source_files = 'YolandaFramework/**/*'
  s.vendored_libraries = 'YolandaFramework/**/*.a'
  s.public_header_files= 'YolandaFramework/**/*.h'
  s.static_framework = true
end
