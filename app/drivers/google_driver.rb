module ChessClubMatchMaker
  class GoogleDriver
    def student_list_worksheet
      @student_list_worksheet ||= chessclub_spreadsheet.worksheet_by_title("Student List")
    end

    def scores_worksheet
      @scores_list_worksheet ||= chessclub_spreadsheet.worksheet_by_title("Scores")
    end

    def each_week(&block)
      (1..10).each_with_index do |week_number|
        worksheet = chessclub_spreadsheet.worksheet_by_title("Week #{week_number}") 
        break if worksheet.nil?

        yield week_number, worksheet
      end
    end

    private

    def chessclub_spreadsheet
      google_session.spreadsheet_by_key(spreadsheet_key)
    end

    def spreadsheet_key
      ChessClubMatchMaker.config.spreadsheet_key
    end

    def google_session
      @session ||= GoogleDrive.saved_session("config.json")
    end
  end
end
