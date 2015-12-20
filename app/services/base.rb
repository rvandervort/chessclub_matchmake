require 'ostruct'

module ChessClubMatchMaker
  class ServiceBase
    attr_accessor :options

    def self.invoke(options = {})
      service = self.new
      service.options = options
      service.execute!
    end
  end
end
