require 'miko/base.rb'
module Miko 
  class Drupal < Miko::Base

    def initialize( path )
      super( path )
      versions = []

      ## Verify that this is indeed Drupal's 
      File.open( path ).each_line {|x| versions << x if x =~ /Drupal.*/ }
      unless versions.empty?
        @version  = versions[0][/([\d.]+)/]
        @script   = "Drupal"
        @acct_home = path.gsub("CHANGELOG.txt", "")
      end

    end

  end
end
