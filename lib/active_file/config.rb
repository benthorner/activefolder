module ActiveFile
  class Config
    attr_accessor :connection_path

    def initialize
      self.connection_path = '.'
    end
  end
end
