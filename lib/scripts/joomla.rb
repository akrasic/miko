require 'miko/base.rb'
module Miko 
  class Joomla < Miko::Base

    def initialize( path )
      super( path )
      
      ## Load ver 
      ver         = File.read( path )[/.*RELEASE.*/][/([\d.]+)/]
      dev         = File.read( path )[/DEV_LEVEL.*/][/\d+/]

      @version     = "#{ver}.#{dev}"
      @acct_home   = path.split("libraries")[0]
      @script      = "Joomla"
    end
    
    def returnversion(path)
      File.read( path )[/.*wp_version.*=.*$/][/([\d.]+)/]
    end

  end
end
