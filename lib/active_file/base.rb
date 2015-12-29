require 'ostruct'

require 'active_file/model/traits/persistence'
require 'active_file/model/traits/has_belongs'
require 'active_file/model/errors'

module ActiveFile
  class Base < OpenStruct
    include Model::Traits::Persistence
    include Model::Traits::HasBelongs
    extend Model::Traits::Collection

    class << self
      def model_name
        model = name.demodulize
        model.underscore.pluralize
      end

      def model_class; self; end
      def model_base_dir; '/' end
    end

    def path
      required(:name); required(:base_dir)
      File.join(base_dir, name)
    end

    def attributes
      self.to_h.except(:name, :base_dir)
    end

    private

    def required(attr)
      return unless attr.to_s.empty?
      raise MissingAttributeError.new(attr)
    end
  end
end
