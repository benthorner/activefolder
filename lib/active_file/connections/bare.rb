module ActiveFile
  module Connections
    class Bare
      attr_accessor :root_path

      def initialize(root_path)
        self.root_path = root_path
      end
    end
  end
end
