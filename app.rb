require 'rubygems'
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __FILE__)
require 'bundler/setup'

$: << File.expand_path('../app', __FILE__)
$: << File.expand_path('../app/services', __FILE__)
$: << File.expand_path('../app/models', __FILE__)

module ChessClubMatchMaker; end

require 'dotenv'
Dotenv.load

require 'config'
require 'services/student_list_provider_service'
require 'services/matchup_service'
require 'models/student'
require 'models/match'

matchups = ChessClubMatchMaker::MatchupService.invoke(student_list: ChessClubMatchMaker::StudentListProviderService.invoke).matches

matchups.each do |matchup|
  puts matchup.to_csv
end
