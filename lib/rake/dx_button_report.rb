
require 'rake'
require 'rake/tasklib'
require 'fileutils'

module StarCitizenWarthog
  module Rake
    
    # Scan the TARGET source code file and report used/unused/duplicated DirectX buttons.
    class DXButtonReport < ::Rake::TaskLib
      
      attr_accessor :name
      
      def initialize name = :dx_button_report
        @name = name
        yield self if block_given?
        
        desc "Scan the TARGET source code file and report used/unused/duplicated DirectX buttons."
        
        task(name) do
          FileUtils.mkdir_p 'build'
          all_dx_buttons = (1..32).map { |i| i }
          
          source_code = File.open('star_citizen.tmc', 'r').read
          used_dx_buttons = source_code.scan(/^\s*define\s+\w+\s+DX(\d+)/).flatten.map(&:to_i).sort
          unused_dx_buttons = all_dx_buttons - used_dx_buttons
          
          # Find button numbers used more than once.
          used_count = Hash.new { |h,k| h[k] = 0 }
          used_dx_buttons.each { |i| used_count[i] += 1 }
          duplicated_dx_buttons = used_count.select { |k,v| v > 1 }.keys
          
          # Print report.
          puts str = <<EOS

Used DirectX buttons:
#{used_dx_buttons.uniq.join ', '}

Duplicated DirectX buttons:
#{duplicated_dx_buttons.join ', '}

Unused DirectX buttons:
#{unused_dx_buttons.join ', '}
EOS
        end
      end
      
    end
  end
end
