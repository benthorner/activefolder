require 'active_folder/errors'

module ActiveFolder
  module Model
    class MissingAttributeError < Error; end
    class TypeError < Error; end
  end
end
