##
### Base class for script modules
### Provides with necessary helpers to successfulyl
### tie up the integration.

module Miko
  class Base
    attr_accessor :path, :acct_home, :version, :script

    def initialize( path )
      @path = path 
    end

    # Output formatted version string
    def showVersion
      unless defined?(@version).nil?
        unless @version.nil? or @version.empty?
          "%-20s %-30s %20s" % [ @script, @version, @acct_home]
        end
      end
    end

  end
end
