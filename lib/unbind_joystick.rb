
# ------------------------------------------------------------------------------
# Unbind all joystick controls.
# ------------------------------------------------------------------------------

require 'rexml/document'

def attach_attributes element, **attributes
  attributes.each { |k, v| element.attributes[k.to_s] = v }
end


remap_doc = REXML::Document.new

root = remap_doc.add_element('ActionMaps').tap do |e|
  attach_attributes e, version: 1
end

root.add_element('CustomisationUIHeader').tap do |e|
  attach_attributes e,
    device: "joystick",
    label: "JoystickTMWarthog",
    description: "@ui_JoystickTMWarthogDesc",
    image: "JoystickTMWarthog"
end

root.add_element('deviceoptions').tap do |e|
  attach_attributes e, name: 'Joystick - HOTAS Warthog'
  
  # Deadzone settings.  
  {x: 0.015, y: 0.015}.each do |input, deadzone|
    e.add_element('option').tap do |o|
      attach_attributes o, input: input, deadzone: deadzone
    end
  end
end

# Joystick exponent setting for joysticks 1-4.
(1..4).each do |i|
  root.add_element('options').tap do |e|
    attach_attributes e, type: 'joystick', instance: i
    e.add_element('pilot').tap { |e| attach_attributes e, exponent: 1 }
  end
end


# Key bindings.
profile_doc = REXML::Document.new File.new('defaultProfile.xml')

profile_doc.root.elements.each('actionmap') do |actionmap|
  root.add_element(actionmap.name).tap do |am|
    attach_attributes am, name: actionmap.attributes['name']
    
    actionmap.elements.each('action') do |action|
      # puts "#{actionmap.attributes['name']}/#{action.attributes['name']} :: #{action.attributes['joystick']}" \
      #   if action.attributes['joystick'] and not action.attributes['joystick'].strip.empty?
      
      am.add_element(action.name).tap do |a|
        attach_attributes a, name: action.attributes['name']
        a.add_element('rebind').tap do |r|
          attach_attributes r, device: 'joystick', input: ''
        end
      end
    end
  end
end

File.open('unbind_joystick.xml', 'w') do |f|
  remap_doc.write f, 4
end
# remap_doc.write $stdout, 4
