require 'active_support/all'

require 'active_folder/base'
require 'active_folder/config'
require 'active_folder/metal/client'

module ActiveFolder
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
