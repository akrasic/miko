
class Miko
  attr_accessor :user
  attr_accessor :directory
  attr_accessor :found
  attr_accessor :path
  attr_accessor :verbose

  def initialize( option )
    unless option[:user].nil?
      @user       = option[:user]
      @directory  = "/home/#{option[:user]}/public_html"
    end

    unless option[:directory].nil?
      @directory  = option[:directory]
    end

    unless option[:verbose]
      @verbose = option[:verbose]
    end

    @found      = []
  end

  def run
    if File.directory?(@directory ) and File.readable?(@directory)
      find_installs

    else
      unless defined?(@verbose).nil?
        raise "Problem accessing directory"
      end
    end
  end

  private
  ##
  ## Skip /home/virtfs
  def find_installs
    Find.find( @directory ) do |path|
      @path = path
      if File.readable_real?(path)
        if path[/virtfs/].nil?
          if path =~ /.*\/version\.php$/
            find_wordpress_joomla
            find_moodle
          elsif path =~ /.*\/bootstrap.inc$/
            find_drupal
          elsif path =~ /.*\/modules\/system\/system.module$/
            find_drupal
          elsif path =~ /.*\/index.php$/
            find_smf_version
          elsif path =~ /.*\/app\/Mage.php$/
            find_magento_version
          elsif path =~ /.*\/styles\/prosilver\/template\/template.cfg$/
            find_phpbb_version
          elsif path =~/.*\/inc\/class_core.php$/
            find_mybb_version
          end
        end
      else
        unless defined?( @verbose).nil?
          puts "Problem accessing #{path}"
        end
      end
    end
  end


  def output( acct_home, version,script  )
    unless version.nil? or version.empty?
      @found << "#{script} #{version}\t=>\t#{acct_home}"
    end
  end

  ##
  ## Wp and Joomla share the same filename for its version file
  def find_wordpress_joomla
    File.open( @path, "r" ).each_line do |line|
      if ( line["wp_version ="] )
        version =  line.split(" ")[2][/([\d.]+)/]
        acct_home  = path.gsub("/wp-includes/version.php", "")
        script     = "Wordpress"
      elsif ( line["$RELEASE"] )
        if @path =~ /.*\/libraries\/cms\/version\/version.php$/ ||  @path =~ /.*\/libraries\/joomla\/version.php$/
          version = line[/([\d.]+)/]+ "."+ joomla_devlevel
          acct_home = path.split("libraries")[0]
          script = "Joomla"
        end
      end
      # Output ony when we has a defined variable
      unless defined?(version).nil?
        output( acct_home, version, script )
      end
    end
  end

  def joomla_devlevel
        File.read( @path )[/DEV_LEVEL.*'/][/\d+/]
  end

  ## Find Drupal version
  def find_drupal
    File.open( @path, "r").each_line do |line|
      if (line["define('VERSION"] )
        version = line.split(" ")[1][/([\d.]+)/]
        ## Drupal 6 / Drupal7 compatability
        if path =~ /.*\/modules\/system\/system.module$/
          acct_home = path.gsub("modules/system/system.module", "")
        else
          acct_home = path.gsub("includes/bootstrap.inc", "")
        end
        script = "Drupal"
      end
      unless defined?(version).nil?
        output( acct_home, version, script)
      end
    end
  end

  def find_smf_version
    File.open( @path, "r").each_line do |line|
      if ( line["$forum_version"] )
        version   = line.split("=")[1][/([\d.]+)/]
        acct_home = path.gsub("index.php", "")
        script    = "SMF Forum"
      end
      unless defined?(version).nil?
        output( acct_home, version, script)
      end
    end
  end

  def find_magento_version
    File.open( @path, "r").each_line do |line|
      if ( line[/'major'.*=>.*/])
        major     = line[/[0-9]/]
        script    = "Magento"
        acct_home = path.gsub("app/Mage.php", "")

        sec = File.read(@path)
        minor = sec[/'minor'.*=>.*/][/\d/]
        revision  = sec[/'revision'.*=>.*/][/\d/]
        patch     = sec[/'patch'.*=>.*/][/\d/]
        stability = sec[/'stability'.*=>.*/].split("=>")[1][/[a-z]+/]
        number    = sec[/'number'.*=>.*/][/\d/]

        if stability.nil?
          version = "#{major}.#{minor}.#{revision}.#{patch}"
        else
          version = "#{major}.#{minor}.#{revision}.#{patch}-#{stability}#{number}"
        end
      end

      ## Ship it
      unless defined?(version).nil?
        output( acct_home, version, script)
      end

    end
  end

  ##
  ## phpBB version
  ## Versions are inside the CHANGELOG or the subsilver template
  def find_phpbb_version
    File.open( @path, "r").each_line do |line|
      if ( line["version ="] )
        version   = line.split("=")[1][/([\d.]+)/]
        acct_home = path.gsub("styles/prosilver/template/template.cfg", "")
        script    = "phpBB"
      end

      unless defined?(version).nil?
        output( acct_home, version, script)
      end
    end

  end

  def find_mybb_version
    File.open( @path, "r").each_line do |line|
      if ( line["public $version ="] )
        version     = line.split("=")[1][/([\d.]+)/]
        acct_home   = path.gsub("inc/class_core.php", "")
        script      = "MyBB"
      end

      unless defined?(version).nil?
        output( acct_home, version, script)
      end
    end

  end


  def find_moodle
    File.open(@path, "r").each_line do |line|
      if ( line["$release "] )
        version   = line.split("=")[1].gsub("'", "").split(";")[0]
        acct_home = @path.gsub("version.php", "")
        script    = "Moodle"
      end
      unless defined?(version).nil?
        output( acct_home, version, script)
      end
    end
  end
end
