
class Miko
	attr_accessor :user
	attr_accessor :directory
	attr_accessor :found
	attr_accessor :path
	#
	# Start the class
	def initialize( user )
		@user				=	user
		@directory	=	"/home/#{@user}/public_html"
		@found			= []
	end

	def run
		if File.directory?(@directory )
			 find_installs
		else
				raise "Directory doesn't exist"
		end
	end

	private
	def find_installs
		Find.find( @directory ) do |path|
			@path = path
			if File.readable?(path)
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
			else
				raise "Problem accessing #{path}"
			end
		end
	end

	def output( acct_home, version,script  ) 
		if !version.nil? 
			if !version.empty?
				@found << "#{script} #{version}\t=>\t#{acct_home}" 
			end
		end
	end
	##
	## Wp and Joomla share the same filename for its version file
	def find_wordpress_joomla
		version		= ""
		acct_home	= ""
		script		= ""

		File.open( @path, "r" ).each_line do |line|
			if ( line["wp_version ="] )
				version =  line.split(" ")[2][/([\d.]+)/]
				acct_home  = path.gsub("/wp-includes/version.php", "")
				script     = "Wordpress"
			elsif ( line["public $RELEASE"] )
				version = line.split(" ")[3][/([\d.]+)/]
				acct_home = path.gsub("libraries/cms/version/version.php", "")
				script    = "Joomla"
			elsif (line["var $RELEASE"] )
				version = line.split(" ")[3][/([\d.]+)/]
				acct_home = path.gsub("libraries/joomla/version.php", "")
				script = "Joomla"
			elsif (line["public $DEV_LEVEL" ])
			elsif (line["var $DEV_LEVEL"] )
				version << "." <<  line.split(" ")[3][/[0-9]/].to_s
			end
		end
		output( acct_home, version, script )
	end

	## 
	## Find Drupal version
	def find_drupal
		version   = ""
		acct_home = ""
		script    = ""
		
		File.open( @path, "r").each_line do |line|
			if (line["define('VERSION"] )
				version = line.split(" ")[1][/([\d.]+)/]

				## Drupal 6 / Drupal7 compatability
				if path =~ /.*\/modules\/system\/system.module$/
						acct_home	= path.gsub("modules/system/system.module", "")
				else
					acct_home = path.gsub("includes/bootstrap.inc", "")
				end

				script = "Drupal"
			end
		end
		output( acct_home, version, script)
	end

	def find_smf_version
		version		=	""
		acct_home	=	""
		script		= ""

		File.open( @path, "r").each_line do |line|
			if ( line["$forum_version"] )
					version = line.split("=")[1][/([\d.]+)/]
					acct_home = path.gsub("index.php", "")
					script = "SMF Forum"
			end
		end
		output( acct_home, version, script)
	end		

	def find_magento_version
		acct_home		=	""
		script			=	""
		major				= ""
		minor				= ""
		revision		= ""
		patch				= ""
		stability		=	false
		number			= ""

		File.open( @path, "r").each_line do |line|
			if ( line[/'major'.*=>.*/])
				major			= line[/[0-9]/]
				script		=	"Magento"
				acct_home	=	path.gsub("app/Mage.php", "")
			elsif ( line[/'minor'.*=>.*/] )
				minor			= line[/[0-9]/]
			elsif ( line[/'revision'.*=>.*/] )
				revision	=	line[/[0-9]/]
			elsif ( line[/'patch'.*=>.*/] )
				patch			=	line[/[0-9]/]
			elsif ( line[/'stability'.*=>.*/] )
				stability	= line.split("=>")[1][/[a-z]+/]
			elsif ( line[/'number'.*=>.*/] )
				number = line.split("=>")[1][/[0-9]+/]
			end
		end
		if !stability.nil?
			version = "#{major}.#{minor}.#{revision}.#{patch}-#{stability}#{number}"
		else
			version = "#{major}.#{minor}.#{revision}.#{patch}"
		end
		output( acct_home, version, script)
	end

	##
	## phpBB version
	## Versions are inside the CHANGELOG or the subsilver template
	def find_phpbb_version
		acct_home		=	""
		script			=	""
		version			=	""

		File.open( @path, "r").each_line do |line|
			if ( line["version ="] )
				version		= line.split("=")[1][/([\d.]+)/]
				acct_home	=	path.gsub("styles/prosilver/template/template.cfg", "")
				script		=	"phpBB"
			end
		end
		output( acct_home, version, script)
	end

	def find_mybb_version
		acct_home		= ""
		script			=	""
		version			=	""

		File.open( @path, "r").each_line do |line|
			if ( line["public $version ="] )
				version			=	line.split("=")[1][/([\d.]+)/]
				acct_home		=	path.gsub("inc/class_core.php", "")
				script			=	"MyBB"

			end
		end

		output( acct_home, version, script)
	end		


	def find_moodle
		acct_home		=	""
		script			= ""
		version			=	""

		File.open(@path, "r").each_line do |line|
			if ( line["$release "] )
				version		= line.split("=")[1].gsub("'", "").split(";")[0]
				acct_home	=	path.gsub("version.php", "")
				script		=	"Moodle"
			end

		end
	
		output( acct_home, version, script)
	end
end
