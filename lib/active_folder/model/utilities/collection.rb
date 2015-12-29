require 'active_folder/model/traits/collection'

module ActiveFolder
  module Model
    module Utilities
      class Collection
        include Model::Traits::Collection

        def initialize(owner, collection)
          @owner = owner; @collection = collection
        end

        def model_class
          @collection.classify.constantize
        end

        def model_name; @collection end
        def model_base_dir; @owner.path end
      end
    end
  end
end
