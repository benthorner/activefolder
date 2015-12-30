module ActiveFolder
  module Metal
    module Files
      class Text
        def initialize(dir:, name:)
          @dir = dir; @name = name
        end

        def load
          client.load(path: path)
        end

        def save(content)
          client.save(path: path, data: content.to_s)
        end

        private

        def client
          ActiveFolder.client
        end

        def path
          File.join(@dir, @name)
        end
      end
    end
  end
end
