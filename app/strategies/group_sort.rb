module ChessClubMatchMaker
  module Strategy
    class GroupSort
      def self.match(student_list)
        grouped_by_level(student_list).flat_map do |level, level_group|
          advanced_sort(level_group).each_slice(2).map { |pair| Match.new(pair.first, pair.last) }
        end
      end

      private

      def self.grouped_by_level(student_list)
        student_list.group_by(&:level)
      end

      def self.advanced_sort(student_list)
        student_list.sort { |a,b| compare(a,b) }
      end

      def self.compare(a,b)
        [:level, :wins, :grade, :teacher].each do |property|
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
