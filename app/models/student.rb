module ChessClubMatchMaker
  class Student
    attr_accessor :first_name, :last_name, :grade, :teacher, :wins, :losses, :ties, :level, :weekly_detail

    def initialize
      @weekly_detail = Hash.new(0)
    end

    def to_s
      "#{last_name}, #{first_name} [#{level}-#{wins}-#{grade}]"
    end

    def as_key
      "#{last_name},#{first_name}"
    end

    def to_csv
      [last_name, first_name, grade, level_to_descr, teacher].map { |v| "\"#{v}\"" }.join(",")
    end

    def level_to_descr
      ["Novice", "Beginner", "Intermediate", "Advanced"][level.to_i - 1]
    end
  end
end
