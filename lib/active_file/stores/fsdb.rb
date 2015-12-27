require 'fsdb'
require 'yaml'

require 'active_file/exceptions'

module ActiveFile
  module Stores
    class Fsdb
      OPTIONS = { formats: [::FSDB::YAML_FORMAT] }

      def initialize(connection)
        path = connection.root_path
        @db = ::FSDB::Database.new(path, OPTIONS)
      end

      def load(path)
        try_load(path)
      rescue Psych::SyntaxError => e
        raise Exceptions::BadFormat.new(e)
      end

      def save(path, content)
        try_save(path, content)
      end

      private

      def try_load(path)
        @db[path] || raise_not_found(path)
      end

      def try_save(path, content)
        @db[path] = content
      end

      def raise_not_found(path)
        raise Exceptions::NotFound.new(path)
      end
    end
  end
end
