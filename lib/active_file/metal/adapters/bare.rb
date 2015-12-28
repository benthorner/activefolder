require 'fileutils'

require 'active_file/metal/errors'

module ActiveFile
  module Metal
    module Adapters
      class Bare
        def initialize(connection)
          @root = connection.root_path
        end

        def read(path:)
          File.read full_path(path)
        rescue SystemCallError => e
          raise SystemError.new(e)
        end

        def write(path:, data:)
          dir = File.dirname full_path(path)
          FileUtils.mkdir_p dir
          File.write(full_path(path), data)
        rescue SystemCallError => e
          raise SystemError.new(e)
        end

        private

        def full_path(path)
          File.join(@root, path)
        end
      end
    end
  end
end
