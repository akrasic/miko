require 'miko/base.rb'
module Miko 
  class Wordpress < Miko::Base

    def initialize( path )
      super( path )

      @version     = returnversion( @path )
      @acct_home   = path.gsub("/wp-includes/version.php", "")
      @script      = "Wordpress"
    end
    
    def returnversion(path)
      File.read( path )[/.*wp_version.*=.*$/][/([\d.]+)/]
    end

  end
end
