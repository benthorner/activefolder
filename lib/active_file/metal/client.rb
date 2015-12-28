require 'active_file/metal/adapters/bare'
require 'active_file/metal/connections/bare'

module ActiveFile
  module Metal
    class Client
      def initialize(config)
        @config = config
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

      private

      def adapter
        @adapter ||= Adapters::Bare.new(connection)
      end

      def connection
        @connection ||= Connections::Bare.new(@config)
      end
    end
  end
end
