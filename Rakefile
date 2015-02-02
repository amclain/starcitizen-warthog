
# ------------------------------------------------------------------------------
# Run `rake --tasks` for the full list of tasks that can be performed.
# ------------------------------------------------------------------------------
require 'starcitizen/rake/extract_default_profile'
require_relative 'lib/rake/create_action_list'
require_relative 'lib/rake/dx_button_report'
require_relative 'lib/rake/generate_layout_graphic'
require_relative 'lib/rake/generate_keymap'

task :default => [:generate_keymap, :install]

StarCitizen::Rake::ExtractDefaultProfile.new :extract_profile do |t|
  t.output_dir = 'build'
end

StarCitizenWarthog::Rake::CreateActionList.new
StarCitizenWarthog::Rake::DXButtonReport.new
StarCitizenWarthog::Rake::GenerateLayoutGraphic.new
StarCitizenWarthog::Rake::GenerateKeymap.new

task :install do
  require 'starcitizen-tools'
  require 'fileutils'
  FileUtils.cp 'layout_starcitizen_warthog.xml',
    File.expand_path('CitizenClient\Data\Controls\Mappings', StarCitizen::Config.game_path)
end
