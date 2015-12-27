require 'ostruct'

require 'active_file/traits/persistence'
require 'active_file/exceptions'

module ActiveFile
  class Base < OpenStruct
    include Traits::Persistence

    class << self
      def model_dir
        bare_class = name.demodulize
        bare_class.underscore.pluralize
      end

      def model_class; self end
    end

    def path
      required(:name); required(:base_dir)
      File.join(base_dir, self.class.model_dir, name)
    end

    def attributes
      self.to_h.except(:name, :base_dir)
    end

    private

    def required(attr)
      return if attr
      raise Exceptions::RequiredAttribute.new(attr)
    end
  end
end
