require 'rugged'

module ActiveFolder
  module Metal
    module Connections
      class Git
        def initialize(config)
          @config = config
        end

        def current_path; Dir.pwd end

        def root_path
          rugged.discover(current_path)
        rescue Rugged::RepositoryError => e
          raise SystemError.new(e)
        end

        private

        def rugged; Rugged::Repository end
      end
    end
  end
end
