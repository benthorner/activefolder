module ActiveFolder
  module Model
    module Traits
      module Discovery
        extend ActiveSupport::Concern

        class_methods do
          def current(path = nil)
            pathname = Pathname.new(path)

            dir = pathname.ascend do |file|
              parent_dir = file.parent.basename.to_s
              break(file) if parent_dir == model_name
            end

            model_class.load(dir) if dir
          end
        end
      end
    end
  end
end
