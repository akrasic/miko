module Miko
  class Base
    attr_accessor :path, :acct_home, :version, :script

    def initialize( path )
      @path = path 
    end

    def load
      l = []
      File.open( @path ).each_line do |line|
        l << line
      end
      l
      #File.read( @path )
    end

    def showVersion
      unless defined?(@version).nil?
        unless @version.nil? or @version.empty?
          "#{@script} #{@version}\t=>\t#{@acct_home}"
        end
      end
    end

  end
end