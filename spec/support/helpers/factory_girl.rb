require 'factory_girl'
require 'faker'

Dir.glob('./spec/**/*_factory.rb') do |f|
  require f
end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
