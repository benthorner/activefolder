require 'active_file/model/traits/collection'

module ActiveFile
  module Model
    module Collections
      class HasMany
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
