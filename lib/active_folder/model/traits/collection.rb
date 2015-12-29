require 'active_folder/model/traits/enumeration'

module ActiveFolder
  module Model
    module Traits
      module Collection
        include Enumeration

        def build(**args)
          dir = File.join(model_base_dir, model_name)
          model_class.new(**args.merge(base_dir: dir))
        end

        def create(**args)
          instance = build(**args); instance.save!; instance
        end

        def find_or_create(**args)
          find(args[:name]) || create(**args)
        end
      end
    end
  end
end
