##
## BBPress search class
### BBPress :: http://bbpress.org/
require 'miko/base.rb'
module Miko 
  class BBPress < Miko::Base

    def initialize( path )
      super( path )
      
      ## Load ver 
      @version    = File.read( path )[/.*this->version.*/][/([\d.]+)/]
      @acct_home   = path.gsub("bbpress.php", "")
      @script      = "BBPress"
    end
    
  end
end
