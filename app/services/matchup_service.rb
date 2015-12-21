module ChessClubMatchMaker
  class MatchupService < ServiceBase
    def execute!
      OpenStruct.new(matches: matches)
    end

    def matches
      strategy.match(students)
    end

    def sorted_student_list
      students.sort
    end

    def students
      options[:student_list]
    end

    def strategy
      ChessClubMatchMaker.config.match_strategy
    end
  end
end
