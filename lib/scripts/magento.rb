require 'miko/base.rb'
module Miko 
  class Magento < Miko::Base

    def initialize( path )
      super( path )
      
      magento = { 'major'     =>  File.read( path )[/'major'.*=>.*/][/\d/],
                  'minor'     =>  File.read( path )[/'minor'.*=>.*/][/\d/],
                  'revision'  =>  File.read( path )[/'revision'.*=>.*/][/\d/],
                  'patch'     =>  File.read( path )[/'patch'.*=>.*/][/\d/],
                  'stability' =>  File.read( path )[/'stability'.*=>.*/].split("=>")[1][/[a-z]+/],
                  'number'    =>  File.read( path )[/'number'.*=>.*/][/\d/]
                }

      @acct_home  = path.gsub("app/Mage.php", "")
      @script     = "Magento"

      if magento["stability"].nil?
        @version = "#{magento["major"]}.#{magento["minor"]}.#{magento["revision"]}.#{magento["patch"]}"
      else
        @version = "#{magento["major"]}.#{magento["minor"]}.#{magento["revision"]}.#{magento["patch"]}-#{magento["stability"]}#{magento["number"]}"
      end


    end

  end
end
