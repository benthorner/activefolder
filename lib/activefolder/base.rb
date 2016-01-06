require 'ostruct'

require 'activefolder/model/traits/persistence'
require 'activefolder/model/traits/relation'
require 'activefolder/model/traits/collection'
require 'activefolder/model/errors'

module ActiveFolder
  class Base < OpenStruct
    include Model::Traits::Persistence
    include Model::Traits::Relation
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
      return unless send(attr).to_s.empty?
      raise Model::AttributeError.new(attr)
    end
  end
end
