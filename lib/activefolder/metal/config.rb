require 'rugged'

require 'activefolder/metal/errors'

module ActiveFolder
  module Metal
    class Config
      attr_writer :root_path

      def initialize
        self.root_path = '.'
      end

      def root_path
        @root_path != :git ? @root_path :
          rugged.discover('.').workdir
      rescue Rugged::RepositoryError => e
        raise SystemError.new(e)
      end

      private

      def rugged
        Rugged::Repository
      end
    end
  end
end
