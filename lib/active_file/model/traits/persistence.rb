require 'active_file/metal/files/yaml'
require 'active_file/model/errors'

module ActiveFile
  module Model
    module Traits
      module Persistence
        def load!
          attrs = validate(attribute_file.load)
          attrs.each { |k,v| self[k] = v }
        end

        def save!
          attribute_file.save(attributes)
        end

        def load; self.load! end
        def save; self.save! end

        private

        def validate(attrs)
          return attrs if attrs.respond_to?(:each_pair)
          raise TypeError.new(attrs)
        end

        def attribute_file
          params = { dir: path, name: 'attributes' }
          Metal::Files::Yaml.new(**params)
        end
      end
    end
  end
end
