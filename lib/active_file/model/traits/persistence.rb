require 'active_file/metal/files/yaml'
require 'active_file/model/errors'

module ActiveFile
  module Model
    module Traits
      module Persistence
        extend ActiveSupport::Concern

        included do
          def load!
            attrs = attributes_file.load
            raise TypeError.new(attrs) unless attrs.respond_to?(:each_pair)
            attrs.each { |k,v| self[k] = v }
          end

          def save!
            attributes_file.save(attributes)
          end

          private

          def attributes_file
            params = { dir: path, name: 'attributes' }
            Metal::Files::Yaml.new(**params)
          end
        end

        class_methods do
          def load(path)
            params = { name: File.basename(path),
                       base_dir: File.dirname(path) }

            instance = self.new(**params)
            instance.load!; instance
          end
        end
      end
    end
  end
end
