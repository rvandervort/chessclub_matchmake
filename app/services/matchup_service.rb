module ChessClubMatchMaker
  class MatchupService < ServiceBase
    def execute!
      OpenStruct.new(matches: matches)
    end

    def matches
      sorted_student_list.each_slice(2).map { |pair| Match.new(pair.first, pair.last) }
    end

    def sorted_student_list
      students.sort
    end

    def students
      options[:student_list]
    end
  end
end
