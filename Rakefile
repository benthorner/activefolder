require 'rake_n_bake'
require 'rubygems/package'

task :default => [:"bake:rspec", :"bake:ok_rainbow"]

namespace :active_file do
  desc 'Build and push a gem for each spec in the current directory'
  task :deploy do
    Dir['*.gemspec'].each do |path|
      spec = Gem::Specification.load path
      Gem::Package.build(spec)
    end

    Dir['*.gem'].each do |path|
      system('gem', 'push', path)
      File.delete path
    end
  end

  desc 'Yank the latest versions of each gem in the current directory'
  task :rollback do
    Dir['*.gemspec'].each do |path|
      spec = Gem::Specification.load path
      system( 'gem yank', spec.name, "-v#{spec.version.to_s}")
    end
  end
end
