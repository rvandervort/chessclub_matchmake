module ChessClubMatchMaker
  module Strategy
    class GroupNoviceEtAl
      NOVICE_LEVEL = 1

      def self.match(student_list)
        partition(student_list).flat_map do |level_group|
          advanced_sort(level_group).each_slice(2).map { |pair| Match.new(pair.first, pair.last) }
        end
      end

      private

      def self.partition(student_list)
        student_list.partition { |student| student.level.to_i == NOVICE_LEVEL }
      end

      def self.advanced_sort(student_list)
        student_list.sort { |a,b| compare(a,b) }
      end

      def self.compare(a,b)
        [:level, :grade, :wins, :teacher].each do |property|
          if a.send(property) < b.send(property)
            return -1
          elsif a.send(property) > b.send(property)
            return 1
          end
        end

        return 0
      end
    end
  end
end
