require 'rugged'

module ActiveFolder
  module Metal
    module Connections
      class Git
        def initialize(config)
          @config = config
        end

        def root_path
          rugged.discover(Dir.pwd)
        rescue Rugged::RepositoryError => e
          raise SystemError.new(e)
        end

        private

        def rugged; Rugged::Repository end
      end
    end
  end
end
