require 'activefolder/rspec'

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
