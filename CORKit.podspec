Pod::Spec.new do |s| 
  s.name          = 'CORKit'
  s.version       = '0.0.1'
  s.license       = 'MIT'
  s.summary    = 'CORKit'
  s.homepage  = 'https://github.com/seiyavw/CORKit.git'
  s.author        = { "seiyavw" => "vvww.ssk@gmail.com" }
  s.source        = { :git => "https://github.com/seiyavw/CORKit.git", :tag => "#{s.version}"}
  s.source_files  = "CORKit/**/*.{h,m}"
  s.requires_arc = true
end

