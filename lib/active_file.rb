require 'active_support/all'

require 'active_file/base'
require 'active_file/config'
require 'active_file/metal/client'

module ActiveFile
  class << self
    def setup
      yield config
    end

    def client
      @client ||= Metal::Client.new(config.client)
    end

    private

    def config
      @config ||= Config.new
    end
  end
end
