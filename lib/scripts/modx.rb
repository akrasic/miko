require 'miko/base.rb'
module Miko 
  class ModX < Miko::Base

    def initialize( path )
      super( path )
      
      ## Load ver 
      versions = []
      File.open(path, "r").each {|x| versions << x if x =~ /MODX Revolution/}
      @version    = versions[0].split(" ")[2]
      @acct_home   = path.gsub("core/docs/changelog.txt", "")
      @script      = "ModX"
    end
    
  end
end
