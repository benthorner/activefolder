require 'activefolder/model/utilities/match'

module ActiveFolder
  module Model
    module Traits
      module Validation
        using Utilities::Match

        def validate attribute, schema, message = nil
          before_save do
            unless schema.match(self.send attribute)
              raise ValidationError.new(attribute, schema, message)
            end
          end

          after_load do
            unless schema.match(self.send attribute)
              raise ValidationError.new(attribute, schema, message)
            end
          end
        end
      end
    end
  end
end
