require 'activefolder/errors'

module ActiveFolder
  module Model
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

    class ValidationError < Error
      def initialize(attr, schema, msg = nil)
        if msg then super msg
        else super("#{attr.inspect} does not match #{schema.inspect}")
        end
      end
    end
  end
end
