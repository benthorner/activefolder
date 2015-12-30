require 'pathname'

require 'active_folder/model/utilities/collection'
require 'active_folder/model/utilities/symbol'
require 'active_folder/metal/files/text'

module ActiveFolder
  module Model
    module Traits
      module HasBelongs
        using Utilities::Symbol
        extend ActiveSupport::Concern

        class_methods do
          def has_many collection
            define_method collection do
              Utilities::Collection.new(self, collection)
            end
          end

          def belongs_to element
            define_method element do
              element.to_class.current(self.path)
            end
          end

          def has_one element
            define_method :link_file do |name|
              params = { dir: path, name: name.to_s }
              Metal::Files::Text.new(**params)
            end

            define_method element do
              begin
                path = link_file(element).load
                element.to_class.load(path)
              rescue Metal::NotFoundError => _
              end
            end

            define_method "#{element}=" do |value|
              link_file(element).save(value.path)
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
