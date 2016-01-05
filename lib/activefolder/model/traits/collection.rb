require 'activefolder/model/traits/enumeration'
require 'activefolder/model/errors'

module ActiveFolder
  module Model
    module Traits
      module Collection
        include Enumeration

        def build(args, &block)
          dir = File.join(model_base_dir, model_name)
          args = args.merge(base_dir: dir)

          instance = model_class.new(args)
          yield instance if block_given?; instance
        end

        def create(args, &block)
          instance = build(args, &block);
          instance.save; instance
        end

        def create!(args, &block)
          if find args[:name]
            raise DuplicateError.new args[:name]
          end

          create(args, &block)
        end

        def destroy_all
          all.each { |element| element.destroy }
        end

        def find_or_create(args, &block)
          find(args[:name]) || create(args, &block)
        end

        def find_or_initialize(args, &block)
          find(args[:name]) || build(args, &block)
        end
      end
    end
  end
end
