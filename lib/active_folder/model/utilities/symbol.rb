module ActiveFolder
  module Model
    module Utilities
      module Symbol
        refine ::Symbol do
          def to_class
            to_s.classify.constantize
          end
        end
      end
    end
  end
end
