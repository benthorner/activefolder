module ActiveFile
  module Metal
    module Connections
      class Bare
        def initialize(config)
          @config = config
        end

        def root_path
          @config.root_path
        end
      end
    end
  end
end
