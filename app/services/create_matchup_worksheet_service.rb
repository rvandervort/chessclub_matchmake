module ChessClubMatchMaker
  class CreateMatchupWorksheetService < ServiceBase
    def initialize
      @driver = GoogleDriver.new
    end

    def execute!
      matchups.each_with_index do |matchup, index|
        matchup_worksheet[index + 2, 1] = matchup.first_student.last_name
        matchup_worksheet[index + 2, 2] = matchup.first_student.first_name
        matchup_worksheet[index + 2, 3] = matchup.first_student.grade
        matchup_worksheet[index + 2, 4] = matchup.first_student.level_to_descr
        matchup_worksheet[index + 2, 5] = matchup.first_student.teacher
        matchup_worksheet[index + 2, 6] = "VS"
        matchup_worksheet[index + 2, 7] = matchup.second_student.last_name
        matchup_worksheet[index + 2, 8] = matchup.second_student.first_name
        matchup_worksheet[index + 2, 9] = matchup.second_student.grade
        matchup_worksheet[index + 2, 10] = matchup.second_student.level_to_descr
        matchup_worksheet[index + 2, 11] = matchup.second_student.teacher
      end
      matchup_worksheet.save
    end

    private

    attr_accessor :driver

    def week_number
      options[:week_number]
    end

    def matchups
      options[:matchups]
    end

    def matchup_worksheet
      @worksheet ||= driver.worksheet_for_week(week_number)
    end
  end
end
