require 'google/api_client'
require 'google_drive'

require 'services/base.rb'

module ChessClubMatchMaker
  class AccumulateScoresService < ServiceBase
    def initialize
      @driver = GoogleDriver.new
    end

    def execute!
      accumulate_scores
      save_scores
    end

    private

    attr_accessor :driver

    def accumulate_scores
      driver.each_week do |week_number, sheet|
        sheet.rows.each do |matchup_row|
          winner = [matchup_row[11], matchup_row[12]].join(",")

          next if winner == ","

          begin
            student = student_list.fetch(winner)
            student.wins += 1
            student.weekly_detail[week_number] += 1

          rescue KeyError => ke
            puts "Couldn't find: #{winner}"
          end
        end
      end
    end

    def print_scores
      student_list.each do |name, student|
        puts [student.last_name, student.first_name, student.wins].join(",")
      end
    end

    def student_list
      @student_list ||= StudentListProviderService.invoke.reduce({}) do |list, student|
         list["#{student.last_name},#{student.first_name}"] = student
         list
      end
    end

    def save_scores
      row_number = 2
      student_list.each do |name, student|
        score_sheet[row_number, 1] = student.last_name
        score_sheet[row_number, 2] = student.first_name
        score_sheet[row_number, 3] = student.grade
        score_sheet[row_number, 4] = "#{student.level} - #{student.level_to_descr}"
        score_sheet[row_number, 5] = student.teacher
        score_sheet[row_number, 6] = student.wins

        student.weekly_detail.each do |week, score|
          score_sheet[row_number, 6 + week] = score
        end

        row_number += 1
      end

      score_sheet.save
    end

    def score_sheet
      driver.scores_worksheet
    end
  end
end
