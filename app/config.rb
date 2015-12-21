module ChessClubMatchMaker
  def self.config
    @config ||= Config.new
  end

  class Config
    def initialize
      @keys = {
        spreadsheet_key:    ENV['SPREADSHEET_KEY'],
        match_strategy_name:   ENV['MATCH_STRATEGY']
      }
    end

    def [](key)
      @keys[key]
    end

    def spreadsheet_key
      keys[:spreadsheet_key]
    end

    def match_strategy
      ChessClubMatchMaker::Strategy.const_get(match_strategy_class_name)
    end

    private

    def match_strategy_class_name
      keys[:match_strategy_name].split("_").map(&:capitalize).join
    end


    attr_reader :keys
  end
end
