require 'active_support/all'
require 'pathname'
require 'yaml'

require 'activefolder/base'
require 'activefolder/config'
require 'activefolder/metal/client'

module ActiveFolder
  class << self
    def setup
      yield config
    end

    def client
      @client ||= Metal::Client.new(config.client)
    end

    def config
      @config ||= Config.new
    end
  end
end
