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

        ChessClubMatchMaker::CreateMatchupWorksheetService.invoke(matchups: matchups, week_number: week_number)
      end

      private

      def student_list
        @student_list ||= ChessClubMatchMaker::StudentListProviderService.invoke
      end

      def matchups
        @matches ||= ChessClubMatchMaker::MatchupService.invoke(student_list: student_list, week_number: week_number).matches
      end

      def week_number
        arguments[0]
      end
    end
  end
end
