require 'active_file/metal/config'

module ActiveFile
  class Config
    attr_reader :client

    def initialize
      @client = Metal::Config.new
    end
  end
end
