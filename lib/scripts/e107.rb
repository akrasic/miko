require 'miko/base.rb'
module Miko 
  class E107 < Miko::Base

    def initialize( path )
      super( path )
      
      ## Load ver 
      ver         = File.read( path )[/.*e107_version.*/]
      unless ver.nil?
        @version      = ver.split("=")[1][/([\d.]+)/]
        @acct_home    = path.gsub("e107_admin/ver.php", "")
        @script       = "e107"
      end
    end
    
  end
end
