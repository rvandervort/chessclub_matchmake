module ChessClubMatchMaker
  class Match
    attr_accessor :first_student, :second_student

    def initialize(first_student, second_student)
      @first_student, @second_student = first_student, second_student
    end

    def to_csv
      [first_student.to_csv, "VS", second_student.to_csv].join(",")
    end
  end
end
