
require 'rake'
require 'rake/tasklib'
require 'rexml/document'
require 'fileutils'

module StarCitizenWarthog
  module Rake
    
    # Creates a tree of action names from defaultProfile.xml
    class CreateActionList < ::Rake::TaskLib
      
      attr_accessor :name
      
      def initialize name = :create_action_list
        @name = name
        yield self if block_given?
        
        desc "Creates a tree of action names from defaultProfile.xml"
        
        task(name) do
          FileUtils.mkdir_p 'build'
          doc = REXML::Document.new File.new('build/defaultProfile.xml')
          output = File.open 'build/action_list.txt', 'w'

          doc.root.elements.each('actionmap') do |actionmap|
            output.puts actionmap.attributes['name']
            actionmap.elements.each('action') do |action|
              output.puts "\t#{action.attributes['name']}"
            end
          end
        end
      end
      
    end
  end
end
