require 'active_file/model/collections/has_many'

module ActiveFile
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
