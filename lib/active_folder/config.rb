require 'active_folder/metal/config'

module ActiveFolder
  class Config
    attr_reader :client

    def initialize
      @client = Metal::Config.new
    end
  end
end
