package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name         = package['name'].split('/')[1..-1].join('/')
  s.version      = package['version']
  s.summary      = 'React Native background downloader'
  s.description  = package['description']
  s.author       = package['author']
  s.homepage     = package['repository']['url']
  s.license      = package['license']
  s.platform     = :ios, '13.4'
  s.source       = { git: 'https://github.com/kesha-antonov/react-native-background-downloader.git', tag: 'master' }
  s.source_files = 'ios/**/*.{h,m,mm,cpp}'
  s.requires_arc = true

  # Use the React Native install_modules_dependencies helper to conditionally include
  # dependencies based on whether the New Architecture is enabled
  install_modules_dependencies(s)
end
