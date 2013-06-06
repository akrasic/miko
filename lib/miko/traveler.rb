##
## Glue that class Miko::Applications
##
require 'miko/applications.rb'

module Miko
  class Traveler < Miko::Applications
    attr_accessor :paths
    attr_accessor :user, :directory, :found, :path, :verbose
    attr_accessor :list

    def initialize( option )
      super( option )

      unless option[:user].nil?
        @user       = option[:user]
        @directory  = "/home/#{user}/public_html/"
      end

      unless option[:directory].nil?
        @directory  = option[:directory]
      end

      unless option[:verbose].nil?
        @verbose    = option[:verbose]
      end

      unless option[:list].nil?
        @list = option[:list]
      end

      @found        = []

    end
    ## Define your awesum stuff here
    def run(  )
      if !defined?(@list).nil?
        listScripts
      else
        if File.directory?(@directory) and File.readable?(@directory)

          Find.find( directory ) do |path|
            if File.readable_real?(path)
              if path[/virtfs/].nil?
                checkScripts( path.chomp )
              end
            end
            end

        else
          unless defined?(@verbose).nil?
            raise "Problem accessing directory #{@directory}"
          end
        end
      end
    end

    def listScripts
      puts "Supported scripts\n----------------------"
      @applist.each do |script, val|
        puts "- #{script}"
      end
    end



  end #EOC
end #EOM
