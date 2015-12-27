require 'active_support/all'

require 'active_file/base'
require 'active_file/config'
require 'active_file/stores/fsdb'
require 'active_file/connections/bare'

module ActiveFile
  class << self
    def configure
      yield config
    end

    def store
      @store ||= Stores::Fsdb.new(connection)
    end

    private

    def connection
      Connections::Bare.new(config.connection_path)
    end

    def config
      @config ||= Config.new
    end
  end
end
