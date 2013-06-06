require 'miko/base.rb'
module Miko 
  class Concrete5 < Miko::Base

    def initialize( path )
      super( path )
      
      ## Load ver 
      @version    = File.read( path )[/.*APP_VERSION.*/][/([\d.]+)/]
      @acct_home   = path.gsub("concrete/config/version.php", "")
      @script      = "Concrete5"
    end
    
  end
end
