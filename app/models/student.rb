module ChessClubMatchMaker
  class Student
    attr_accessor :first_name, :last_name, :grade, :teacher, :wins, :losses, :ties, :level

    def <=>(other)
      [:level, :wins, :grade, :teacher].each do |property|
        if self.send(property) < other.send(property)
          return -1
        elsif self.send(property) > other.send(property)
          return 1
        end
      end

      return 0
    end

    def to_s
      "#{last_name}, #{first_name} [#{level}-#{wins}-#{grade}]"
    end

    def to_csv
      [last_name, first_name, grade, level_to_descr(level - 1), teacher].map { |v| "\"#{v}\"" }.join(",")
    end

    def level_to_descr(lev)
      ["Novice", "Beginner", "Intermediate", "Advanced"][lev]
    end
  end
end
