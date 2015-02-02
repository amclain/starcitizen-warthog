
# ------------------------------------------------------------------------------
# Run `rake --tasks` for the full list of tasks that can be performed.
# ------------------------------------------------------------------------------
require 'starcitizen/rake/extract_default_profile'
require_relative 'lib/rake/create_action_list'

StarCitizen::Rake::ExtractDefaultProfile.new :extract_profile do |t|
  t.output_dir = 'build'
end

StarCitizenWarthog::Rake::CreateActionList.new
