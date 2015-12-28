require 'ostruct'

require 'active_file/traits/persistence'
require 'active_file/errors'

module ActiveFile
  class Base < OpenStruct
    include Traits::Persistence

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
