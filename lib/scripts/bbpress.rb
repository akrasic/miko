##
## BBPress search class
### BBPress :: http://bbpress.org/
require 'miko/base.rb'
module Miko
  class BBPress < Miko::Base

    def initialize( path )
      super( path )

      ##
      ## Skip any false bbpress.php files
      ver         = File.read( path )[/.*this->version.*/]
      unless ver.nil?
        @version    = ver[/([\d.]+)/]
        @acct_home  = path.gsub("bbpress.php", "")
        @script     = "BBPress"
      end
    end

  end
end
