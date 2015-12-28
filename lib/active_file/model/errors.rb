require 'active_file/errors'

module ActiveFile
  module Model
    class MissingAttributeError < Error; end
    class TypeError < Error; end
  end
end
