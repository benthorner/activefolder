require 'activefolder'

RSpec.configure do |config|
  config.after(:each) do
    root_path = ActiveFolder.config.client.root_path
    FileUtils.rm_rf root_path
  end

  config.before(:each) do
    root_path = ActiveFolder.config.client.root_path
    FileUtils.rm_rf root_path
  end
end
