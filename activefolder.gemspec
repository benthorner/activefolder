require 'semver'

Gem::Specification.new do |s|
  s.name = 'activefolder'
  s.version = SemVer.find.format "%M.%m.%p%s"
  s.licenses = 'GNU GPL v2.0'
  s.summary = 'A file system ORM based on ActiveRecord.'
  s.description = 'A file system ORM based on ActiveRecord. Objects are files, relations are folders.'
  s.authors = ['Ben Thorner']
  s.email = 'benthorner@outlook.com'
  s.files = Dir['lib/**/*.rb']
  s.required_ruby_version = '>= 2.2.2'
  s.homepage = 'https://github.com/benthorner/active_folder'

  s.add_runtime_dependency 'activesupport', '~> 4.2', '>= 4.2.5'
end
