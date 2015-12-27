require 'active_file'

RSpec.configure do |config|
  config.after(:all) do
    Dir.glob('tmp/*').each { |f| FileUtils.rm_rf(f) }
  end

  config.before(:all) do
    Dir.glob('tmp/*').each { |f| FileUtils.rm_rf(f) }
  end
end

ActiveFile.configure do |config|
  config.connection_path = 'tmp'
end
