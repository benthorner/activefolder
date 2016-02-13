module ActiveFolder
  module Model
    module Utilities
      module Match
        refine Object do
          def match(object); self == object end
        end

        refine Class do
          def match(object); object.is_a? self end
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
              Array(object).any? do |element|
                condition.match(element)
              end
            end
          end
        end

        refine Regexp do
          alias_method :match!, :match

          def match(object)
            match! object
          rescue TypeError
            false
          end
        end
      end
    end
  end
end
