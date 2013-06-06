require 'miko/base.rb'
module Miko 
  class MyBB < Miko::Base

    def initialize( path )
      super( path )
      
      ## Load ver 
      ver         = File.read( path )[/.*public.*version.*=.*/]
      unless ver.nil?
        @version    = ver[/([\d.]+)/]
        @acct_home  = path.gsub("inc/class_core.php", "")
        @script     = "MyBB"
      end
    end
    
  end
end
