require 'commands/base'
module ChessClubMatchMaker
  module Commands
    class AccumulateScores < CommandBase
      def execute!
        AccumulateScoresService.invoke
      end

      private
    end
  end
end
