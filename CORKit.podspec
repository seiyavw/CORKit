Pod::Spec.new do |s| 
  s.name          = 'CORKit'
  s.version       = '0.0.1'
  s.license       = 'MIT'
  s.summary    = 'CORKit'
  s.homepage  = 'https://github.com/seiyavw/CORKit.git'
  s.author        = "seiyavw"
  s.source        = { :git => "https://github.com/seiyavw/CORKit.git", :tag => "#{s.version}"}
  s.requires_arc = true

  s.ios.deployment_target = '6.0'

  s.source_files = 'CORKit/CORKit.h'
  s.public_header_files = 'CORKit/**/*.h'

  s.subspec 'Category' do |ss|
    ss.source_files = 'CORKit/Category/*.{h,m}'
  end

  s.subspec 'Extention' do |ss|
    ss.source_files = 'CORKit/Extension/*.{h,m}'
  end

  s.subspec 'Util' do |ss|
    ss.source_files = 'CORKit/Util/*.{h,m}'
  end
end

