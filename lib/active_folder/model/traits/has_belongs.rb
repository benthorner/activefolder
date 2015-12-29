require 'active_folder/model/collections/has_many'

module ActiveFolder
  module Model
    module Traits
      module HasBelongs
        extend ActiveSupport::Concern

        class_methods do
          def has_many collection
            define_method collection do
              Collections::HasMany.new(self, collection.to_s)
            end
          end
        end
      end
    end
  end
end
