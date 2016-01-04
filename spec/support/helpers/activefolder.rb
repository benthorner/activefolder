require 'activefolder'

RSpec.configure do |config|
  config.after(:each) do
    Dir.glob('tmp/*').each { |f| FileUtils.rm_rf(f) }
  end

  config.before(:each) do
    Dir.glob('tmp/*').each { |f| FileUtils.rm_rf(f) }
  end
end

ActiveFolder.setup do |config|
  config.client.root_path = 'tmp'
end

class Model < ActiveFolder::Base
  has_many :model_children
  has_one :model_sibling
end

class ModelChild < ActiveFolder::Base
  belongs_to :model
end

class ModelSibling < ActiveFolder::Base; end
