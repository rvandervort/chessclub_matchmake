require 'google/api_client'
require 'google_drive'

require 'services/base.rb'

module ChessClubMatchMaker
  class StudentListProviderService < ServiceBase
    def execute!
      @mapped_student_list ||= student_list.map do |row|
        map_row_to_student(row)
      end
    end

    private

    def map_row_to_student(row)
      s = Student.new

      s.first_name = row[1]
      s.last_name = row[0]
      s.grade = row[2]

      s.wins = row[5]

      s.level = row[3].split(" ").first.to_i
      s.teacher = row[4]
      s
    end

    def student_list
      student_list_worksheet.rows[1..-1]
    end

    def student_list_spreadsheet
      google_session.spreadsheet_by_key(spreadsheet_key)
    end

    def spreadsheet_key
      ChessClubMatchMaker.config.spreadsheet_key
    end

    def google_session
      @session ||= GoogleDrive.saved_session("config.json")
    end

    def student_list_worksheet
      @worksheet ||= student_list_spreadsheet.worksheet_by_title("Scores")
    end
  end
end
