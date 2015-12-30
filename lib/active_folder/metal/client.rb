require 'active_folder/metal/adapters/bare'
require 'active_folder/metal/connections/bare'
require 'active_folder/metal/connections/git'

module ActiveFolder
  module Metal
    class Client
      def initialize(config)
        @config = config
        @connection = connect(config)
      end

      def load(**args)
        adapter.read(**args)
      end

      def save(**args)
        adapter.write(**args)
      end

      def glob(**args)
        adapter.glob(**args)
      end

      def connection
        @connection
      end

      private

      def connect(config)
        case config.root_path
          when :git then Connections::Git.new(config)
          else Connections::Bare.new(config)
        end
      end

      def adapter
        @adapter ||= Adapters::Bare.new(connection)
      end
    end
  end
end
