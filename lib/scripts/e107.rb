require 'miko/base.rb'
module Miko 
  class E107 < Miko::Base

    def initialize( path )
      super( path )
      
      ## Load ver 
      @version    = File.read( path )[/.*e107_version.*/].split("=")[1][/([\d.]+)/]
      @acct_home   = path.gsub("e107_admin/ver.php", "")
      @script      = "e107"
    end
    
  end
end
