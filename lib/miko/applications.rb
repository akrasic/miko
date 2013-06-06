##
## Main miko controller
## Include, specify and add new modules and regex defs
##

require 'scripts/wordpress.rb'
require 'scripts/joomla.rb'
require 'scripts/drupal.rb'
require 'scripts/smf.rb'
require 'scripts/magento.rb'
require 'scripts/phpbb.rb'
require 'scripts/mybb.rb'
require 'scripts/moodle.rb'
require 'scripts/concrete5.rb'
require 'scripts/e107.rb'
require 'scripts/bbpress.rb'
require 'scripts/modx.rb'

module Miko
  class Applications
    attr_accessor :applist, :option
    attr_accessor :user, :directory, :found, :path, :verbose

    def initialize(option)
      @option = option
      ## Add to applist
      ## name => /regxp
      @applist= { 'wordpress' =>  /.*\/wp-includes\/version.php$/,
                  'joomla15'  =>  /.*\/libraries\/joomla\/version.php$/,
                  'joomla25'  =>  /.*\/libraries\/cms\/version\/version.php$/,
                  'drupal'    =>  /.*\/CHANGELOG.txt$/,
                  'smf'       =>  /.*\/index.php$/,
                  'magento'   =>  /.*\/app\/Mage.php$/,
                  'phpbb'     =>  /.*\/styles\/prosilver\/template\/template.cfg$/,
                  'mybb'      =>  /.*\/inc\/class_core.php$/,
                  'moodle'    =>  /.*\/version.php$/,
                  'concrete5' =>  /.*\/concrete\/config\/version.php$/,
                  'e107'      =>  /.*\/e107_admin\/ver.php$/,
                  'modx'      =>  /.*\/core\/docs\/changelog.txt$/,
                  'bbpress'   =>  /.*\/bbpress.php$/
                  }
    end



    def final_find( script, file )
      case script
      when 'wordpress'
        wp =  Miko::Wordpress.new( file )
        wp.showVersion()
      when  'joomla15', 'joomla25'
        j = Miko::Joomla.new( file )
        j.showVersion()

      when "drupal"
        drupal  = Miko::Drupal.new( file )
        drupal.showVersion()

      when "smf"
        smf   = Miko::SMF.new( file )
        smf.showVersion()

      when "magento"
        magento = Miko::Magento.new( file )
        magento.showVersion()

      when "phpbb"
        phpbb = Miko::PHPBB.new( file )
        phpbb.showVersion()

      when "mybb"
        mybb  = Miko::MyBB.new(file)
        mybb.showVersion()

      when "moodle"
        moodle  = Miko::Moodle.new( file )
        moodle.showVersion()

      when "concrete5"
        c5  = Miko::Concrete5.new(file)
        c5.showVersion()
      when "e107"
        e   = Miko::E107.new(file)
        e.showVersion()
      when "bbpress"
        b   = Miko::BBPress.new(file)
        b.showVersion()
      when "modx"
        modx  = Miko::ModX.new(file)
        modx.showVersion()
      end
    end


    ##
    ## Loops trough the defined @applist checking if the provided path wouldn't match
    ## once of defined regex definitions
    def checkScripts( path )
      if @option[:script].empty? 
        @applist.each do |sc, val|
          if !val.match(path).nil?
            f =  final_find(sc, path)
            @found << f if !f.nil?
          end
        end
      else
        @option[:script].each do |sc|
          if !@applist[sc].match(path).nil?
            f = final_find(sc, path)
            @found << f if !f.nil?
          end
        end
      end



    end


  end
end
