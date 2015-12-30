module ActiveFolder
  module Metal
    module Connections
      class Bare
        def initialize(config)
          @config = config
        end

        def root_path
          @config.root_path
        end

        def current_path
          Dir.pwd
        end
      end
    end
  end
end
