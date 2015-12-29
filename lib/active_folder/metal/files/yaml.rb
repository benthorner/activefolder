require 'yaml'

require 'active_folder/metal/errors'

module ActiveFolder
  module Metal
    module Files
      class Yaml
        def initialize(dir:, name:)
          @dir = dir; @name = name
        end

        def load
          YAML.load client.load(path: path)
        rescue Psych::SyntaxError => e
          raise SyntaxError.new(e)
        end

        def save(content)
          data = content.to_yaml
          client.save(path: path, data: data)
        end

        private

        def path
          File.join(@dir, "#{@name}.yaml")
        end

        def client
          ActiveFolder.client
        end
      end
    end
  end
end
