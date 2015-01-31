
# ------------------------------------------------------------------------------
# Extracts defaultProfile.xml from CitizenClient\Data\GameData.pak
# ------------------------------------------------------------------------------

require 'zip'
require 'yaml'

config = YAML.load_file '../config.yaml'
game_directory = config['game_directory']
raise "game_directory not found" unless game_directory

game_data = File.expand_path "#{game_directory}/CitizenClient/Data/GameData.pak"
default_profile = 'defaultProfile.xml'
puts "Extracting #{default_profile} from:\n#{game_data}"

File.delete default_profile if File.exists? default_profile

Zip::File.open(game_data) do |data_files|
  profile = data_files.glob('Libs/Config/defaultProfile.xml').first
  profile.extract profile.name.split('/').last
end
