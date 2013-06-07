require 'miko/base.rb'
module Miko
  class Moodle < Miko::Base

    def initialize( path )
      super( path )

      versions = []
      File.open( path ).each_line {|x| versions << x if x =~ /MOODLE VERSION INFORMATION.*/ }

      unless versions.empty?
        @script     = "Moodle"
        @version    = File.read( path )[/.*release.*=.*/].to_s.split("=")[1].gsub("'", "").split(";")[0].gsub(" ", "")
        @acct_home  = @path.gsub("version.php", "")

      end
    end

  end
end
