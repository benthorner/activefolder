require 'faker'
require 'pry'

require 'support/helpers/activefolder'
require 'support/helpers/factory_girl'

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.order = :random
  Kernel.srand config.seed
end
