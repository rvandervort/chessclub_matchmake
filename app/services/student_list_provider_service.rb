require 'google/api_client'
require 'services/base.rb'
require 'drivers/google_driver'

module ChessClubMatchMaker
  class StudentListProviderService < ServiceBase
    def initialize
      @driver = GoogleDriver.new
    end

    def execute!
      load_win_records

      @mapped_student_list ||= student_list.map do |row|
        map_row_to_student(row)
      end
    end

    private

    attr_accessor :driver, :win_records
    
    def load_win_records
      @win_records = Hash.new
      driver.scores_worksheet.rows.each do |row|
        @win_records["#{row[0]},#{row[1]}"] = row[6].to_i
      end
    end

    def map_row_to_student(row)
      s = Student.new

      s.first_name = row[1]
      s.last_name = row[0]
      s.grade = row[2]

      s.wins = win_records.fetch(s.as_key, 0)

      s.level = row[3].split(" ").first.to_i
      s.teacher = row[4]
      s
    end

    def student_list
      driver.student_list_worksheet.rows[1..-1]
    end
  end
end
