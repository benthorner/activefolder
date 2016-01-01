require 'fileutils'

require 'active_folder/metal/errors'

module ActiveFolder
  module Metal
    module Adapters
      class Local
        def initialize(config)
          @config = config
        end

        def read(path)
          File.read full_path(path)
        rescue Errno::ENOENT => e
          raise NotFoundError.new(e)
        rescue SystemCallError => e
          raise SystemError.new(e)
        end

        def write(path, data)
          File.write(full_path(path), data)
        rescue SystemCallError => e
          raise SystemError.new(e)
        end

        def mkdir_p(path)
          FileUtils.mkdir_p full_path(path)
        rescue SystemCallError => e
          raise SystemError.new(e)
        end

        def rm_r(path)
          FileUtils.rm_r full_path(path)
        rescue SystemCallError => e
          raise SystemError.new(e)
        end

        def glob(path)
          paths = Dir.glob full_path(path)
          paths.map { |p| relative_path(p) }
        rescue SystemCallError => e
          raise SystemError.new(e)
        end

        private

        def full_path(path)
          File.join(@config.root_path, path)
        end

        def relative_path(path)
          path.sub(@config.root_path, '')
        end
      end
    end
  end
end
