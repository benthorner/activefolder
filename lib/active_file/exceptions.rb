module ActiveFile
  module Exceptions
    class RequiredAttribute < StandardError; end
    class FileNotFound < StandardError; end
    class AccessDenied < StandardError; end
    class BadFormat < StandardError; end
  end
end
