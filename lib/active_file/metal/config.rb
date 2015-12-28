module ActiveFile
  module Metal
    class Config
      attr_accessor :root_path

      def initialize
        self.root_path = '.'
      end
    end
  end
end
