require 'activefolder/metal/adapters/local'

module ActiveFolder
  module Metal
    class Client
      def initialize(config)
        @config = config
      end

      def load(path:)
        adapter.read(path)
      end

      def save(path:, data:)
        adapter.mkdir_p File.dirname(path)
        adapter.write(path, data)
      end

      def glob(path:)
        adapter.glob(path)
      end

      def del(path:)
        adapter.rm_r(path)
      end

      private

      def adapter
        Adapters::Local.new(@config)
      end
    end
  end
end
