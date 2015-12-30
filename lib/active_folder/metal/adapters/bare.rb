require 'fileutils'

require 'active_folder/metal/errors'

module ActiveFolder
  module Metal
    module Adapters
      class Bare
        def initialize(connection)
          @root = connection.root_path
        end

        def read(path:)
          File.read full_path(path)
        rescue Errno::ENOENT => e
          raise NotFoundError.new(e)
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

        def glob(path:)
          paths = Dir.glob full_path(path)
          paths.map { |p| relative_path(p) }
        rescue SystemCallError => e
          raise SystemError.new(e)
        end

        private

        def full_path(path)
          File.join(@root, path)
        end

        def relative_path(path)
          path.sub(@root, '')
        end
      end
    end
  end
end
