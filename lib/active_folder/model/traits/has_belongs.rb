require 'pathname'

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

          def belongs_to element
            define_method element do
              model_class = element.to_s.classify.constantize
              model_class.current(self.path)
            end
          end

          def current(path = Dir.pwd)
            pathname = Pathname.new(path)

            dir = pathname.ascend do |file|
              parent_dir = file.parent.basename.to_s
              break(file) if parent_dir == model_name
            end

            model_class.load(dir) if dir
          end
        end
      end
    end
  end
end
