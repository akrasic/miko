require 'miko/base.rb'
module Miko 
  class SMF < Miko::Base

    def initialize( path )
      super( path )
      versions = []

      ## Verify that this is indeed Drupal's 
      File.open( path ).each_line {|x| versions << x if x =~ /.*forum_version.*/ }
      unless versions.empty?
        @version  = versions[0][/([\d.]+)/]
        @script   = "SMF"
        @acct_home = path.gsub("index.php", "")
      end

    end

  end
end
