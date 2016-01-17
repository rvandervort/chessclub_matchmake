require 'rubygems'
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __FILE__)
require 'bundler/setup'

$: << File.expand_path('../app', __FILE__)
$: << File.expand_path('../app/strategies', __FILE__)
$: << File.expand_path('../app/services', __FILE__)
$: << File.expand_path('../app/models', __FILE__)

module ChessClubMatchMaker; end

require 'dotenv'
Dotenv.load

require 'config'

require 'commands/base'
require 'commands/match_maker'
require 'commands/accumulate_scores'

require 'strategies/sort'
require 'strategies/group_sort'
require 'strategies/group_novice_et_al'

require 'services/student_list_provider_service'
require 'services/matchup_service'
require 'services/accumulate_scores_service'

require 'models/student'
require 'models/match'

## Command
args = ARGV
command_name = args.shift
command_options = args

command_class_name = command_name.split("_").map(&:capitalize).join("")

command = ChessClubMatchMaker::Commands.const_get(command_class_name)

command.invoke(command_options)
