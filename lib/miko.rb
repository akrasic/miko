
class Miko
	attr_accessor :user
	attr_accessor :directory
	attr_accessor :found
	#
	# Start the class
	def initialize( user )
		@user = user
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
		final = []
		Find.find( @directory ) do |path|
				if File.readable?(path)
					if path =~ /.*\/version\.php$/
						@found << find_wordpress_joomla( path )
					elsif path =~ /.*\/bootstrap.inc$/
						@found << find_drupal( path )
					end
				
				else
						raise "Error accessing #{path}"
				end
		end
	end


	##
	## Wp and Joomla share the same filename for its version file
	def find_wordpress_joomla( path )
		version   = ""
		acct_home = ""
		script    = ""
		f					= []
		File.open( path, "r" ).each_line do |line|
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
	 "#{script} #{version}\t=>\t#{acct_home}"
	end

	## 
	## Find Drupal version
	def find_drupal( path )
		version   = ""
		acct_home = ""
		script    = ""
		
		File.open( path, "r").each_line do |line|
			if (line["define('VERSION"] )
				version = line.split(" ")[1][/([\d.]+)/]
				acct_home = path.gsub("includes/bootstrap.inc", "")
				script = "Drupal"
			end
		end
		"#{script} #{version}\t=>\t#{acct_home}"
	end

		
end
