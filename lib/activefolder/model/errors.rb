require 'activefolder/errors'

module ActiveFolder
  module Model
    class MissingAttributeError < Error
      def initialize(attr)
        super("Missing attribute #{attr}")
      end
    end

    class DuplicateError < Error
      def initialize(name)
        super("Duplicate object #{name}")
      end
    end

    class NotFoundError < Error
      def initialize(name)
        super("Object not found #{name}")
      end
    end
  end
end
