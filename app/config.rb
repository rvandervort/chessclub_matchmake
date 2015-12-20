module ChessClubMatchMaker
  def self.config
    @config ||= Config.new
  end

  class Config
    def initialize
      @keys = {spreadsheet_key: ENV['SPREADSHEET_KEY']}
    end

    def [](key)
      @keys[key]
    end

    def spreadsheet_key
      keys[:spreadsheet_key]
    end

    private

    attr_reader :keys
  end
end
