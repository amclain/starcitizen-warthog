
require 'yaml'

layout = YAML.load_file '../joystick_layout.yaml'
svg = File.open('../assets/joystick_layout_template.svg').read

layout.each { |key, desc| svg.gsub! "@#{key}", desc.to_s }
svg.gsub!(/@(\w+)/, '')

File.open('../joystick_layout.svg', 'w') do |f|
  f.write svg
end
