# Miko 0.1.1

Search for script installations versions under a account. 

Supported scripts ( so far ):
- Wordpress
- Joomla  1.x , 2.x, 3.x
- Drupal 7.x, 6.x
- Magento
- phpBB
- SMF Forum
- MyBB
- Moodle
- Concrete5
- e107
- BBPress
- ModX

## Installation
`` gem install miko ``

## Usage
You can try to scan for the user accoutn using the "-u"/"--user" flag which translates to /home/USER/ or use "-d"/"--directory" flag to specify an exact directoy you want to scan.
```
Usage: miko [options]
    -u, --user USER                  Username - translates into /home/USER/
    -d, --directory DIRECTORY        Specify directory instead username
    -s, --script SCRIPT              Search for a specific script or scripts.
                        For multiple scripts you can pass them as a list: miko -s wordpress -s smf -d /some/directory
    -l, --list                       Lists supported scripts
    -v, --verbose                    Be verbose and display errors
    -h, --help                       Display Help
```
## Examples
Find scripts for a user account:
`` miko -u USER ``
Find specific scripts for a user or directoy
`` miko -u USER -s wordpress -s phpbb -s joomla``
`` miko -d /home/USER/some/other/dir/  -s wordpress -s phpbb -s joomla``
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

