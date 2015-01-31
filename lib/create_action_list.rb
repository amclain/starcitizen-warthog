
# ------------------------------------------------------------------------------
# Creates a tree of action names from defaultProfile.xml
# ------------------------------------------------------------------------------

require 'rexml/document'

doc = REXML::Document.new File.new('defaultProfile.xml')
output = File.open 'action_list.txt', 'w'

doc.root.elements.each('actionmap') do |actionmap|
  output.puts actionmap.attributes['name']
  actionmap.elements.each('action') do |action|
    output.puts "\t#{action.attributes['name']}"
  end
end
