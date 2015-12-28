module ActiveFile
  class Error < StandardError; end

  class MissingAttributeError < Error; end
  class TypeError < Error; end
end
