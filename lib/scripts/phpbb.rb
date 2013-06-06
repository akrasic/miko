require 'miko/base.rb'
module Miko 
  class PHPBB < Miko::Base

    def initialize( path )
      super( path )
      
      ## Load ver 
      @version    = File.read( path )[/.*version.*=.*/][/([\d.]+)/]
      @acct_home   = path.gsub("styles/prosilver/template/template.cfg", "")
      @script      = "phpBB"
    end
    
  end
end
