
require 'rake'
require 'rake/tasklib'
require 'yaml'

module StarCitizenWarthog
  module Rake
    
    # Create the joystick layout graphic from joystick_layout_template.svg
    class GenerateLayoutGraphic < ::Rake::TaskLib
      
      attr_accessor :name
      
      def initialize name = :generate_layout_graphic
        @name = name
        yield self if block_given?
        
        desc "Create the joystick layout graphic from joystick_layout_template.svg"
        
        task(name) do
          layout = YAML.load_file 'joystick_layout.yaml'
          svg = File.open('assets/joystick_layout_template.svg').read
          
          layout.each { |key, desc| svg.gsub! "@#{key}", desc.to_s }
          svg.gsub!(/@(\w+)/, '')
          
          File.open('joystick_layout.svg', 'w') do |f|
            f.write svg
          end
        end
      end
      
    end
  end
end
