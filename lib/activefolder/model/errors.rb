require 'activefolder/errors'

module ActiveFolder
  module Model
    class MissingAttributeError < Error; end
    class TypeError < Error; end

    class DuplicateError < Error; end
    class NotFoundError < Error; end
  end
end
