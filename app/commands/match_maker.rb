require 'commands/base'
module ChessClubMatchMaker
  module Commands

    # Args
    #  0 = Week Number
    class MatchMaker < CommandBase
      def execute!
        matchups.each do |matchup|
          puts matchup.to_csv
        end
      end

      private

      def student_list
        ChessClubMatchMaker::StudentListProviderService.invoke
      end

      def matchups
        ChessClubMatchMaker::MatchupService.invoke(student_list: student_list).matches
      end

      def week_number
        arguments[0]
      end
    end
  end
end
