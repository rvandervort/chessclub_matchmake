module ChessClubMatchMaker
  module Strategy
    class Sort
      def self.match(student_list)
        advanced_sort(student_list).each_slice(2).map { |pair| Match.new(pair.first, pair.last) }
      end

      private

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
