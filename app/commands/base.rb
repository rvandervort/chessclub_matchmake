require 'ostruct'

module ChessClubMatchMaker
  module Commands
    class CommandBase
      attr_accessor :arguments

      def self.invoke(arguments = {})
        command  = self.new
        command.arguments = arguments
        command.execute!
      end
    end
  end
end
