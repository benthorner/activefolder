require 'active_folder/model/traits/collection'
require 'active_folder/model/utilities/symbol'

module ActiveFolder
  module Model
    module Utilities
      class Collection
        using Utilities::Symbol
        include Model::Traits::Collection

        def initialize(owner, name)
          @owner = owner; @name = name
        end

        def model_class; @name.to_class end
        def model_name; @name.to_s end
        def model_base_dir; @owner.path end
      end
    end
  end
end
