require 'active_folder/model/traits/enumeration'

module ActiveFolder
  module Model
    module Utilities
      module Match
        refine Object do
          def match(object); self == object end
        end

        refine Range do
          def match(object); member?(object) end
        end

        refine Hash do
          def match(object)
            keys.all? do |key|
              if object.kind_of? OpenStruct
                self[key].match object.send(key)
              else
                self[key].match object.to_h[key]
              end
            end
          end
        end

        refine Array do
          def match(object)
            any? do |condition|
              object.to_a.any? do |element|
                condition.match(element)
              end
            end
          end
        end
      end
    end
  end
end
