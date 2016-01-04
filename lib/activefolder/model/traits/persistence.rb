require 'activefolder/metal/files/yaml'
require 'activefolder/model/errors'

module ActiveFolder
  module Model
    module Traits
      module Persistence
        extend ActiveSupport::Concern

        included do
          def load
            attrs = attributes_file.load
            attrs.each_pair do |key,val|
              self[key] = val
            end

            self
          end

          def save
            attributes_file.save(attributes)
            self
          end

          def save!; self.save end

          def update(**args)
            args.each { |k,v| self[k] = v }
            self.save
          end

          def destroy
            ActiveFolder.client.del(path: path)
          end

          private

          def attributes_file
            params = { dir: path, name: 'attributes' }
            Metal::Files::Yaml.new(**params)
          end
        end

        class_methods do
          def load(path)
            instance = new(name: File.basename(path),
                           base_dir: File.dirname(path))

            instance.load; instance
          end
        end
      end
    end
  end
end
