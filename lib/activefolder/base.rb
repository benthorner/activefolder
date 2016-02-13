require 'hooks'
require 'ostruct'

require 'activefolder/model/traits/persistence'
require 'activefolder/model/traits/relation'
require 'activefolder/model/traits/collection'
require 'activefolder/model/traits/validation'
require 'activefolder/model/errors'

module ActiveFolder
  class Base < OpenStruct
    include Hooks
    include Model::Traits::Persistence
    include Model::Traits::Relation
    extend Model::Traits::Collection
    extend Model::Traits::Validation

    define_hooks :before_save, :after_load

    validate :name, /^(?!.*\/).*$/,
      '"name" must not contain slashes'

    validate :name, /.+/,
      '"name" must not be empty'

    validate :base_dir, /.+/,
      '"base_dir" must not be empty'

    def path
      File.join(base_dir, name)
    end

    def attributes
      self.to_h.except(:name, :base_dir)
    end

    class << self
      def model_name
        model = name.to_s.demodulize
        model.underscore.pluralize
      end

      def model_class; self; end
      def model_base_dir; '/' end
    end
  end
end
