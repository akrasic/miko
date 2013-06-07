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

## Output
```
Name                 Version                                Installation 
 
BBPress              2.3.2                          /home/antun/public_html/bbpress/bbpress/
Concrete5            5.6.1.2                        /home/antun/public_html/concrete/concrete5.6.1.2/
Drupal               6.28                           /home/antun/public_html/drupal6/drupal-6.28/
Drupal               7.22                           /home/antun/public_html/drupal7/drupal-7.22/
Joomla               1.5.26                         /home/antun/public_html/j15/
Joomla               3.1.1                          /home/antun/public_html/joomla/
Magento              1.7.0.2                        /home/antun/public_html/magento/magento/
Magento              1.8.0.0-alpha1                 /home/antun/public_html/magento2/magento/
ModX                 2.2.8-pl                       /home/antun/public_html/modx/modx-2.2.8-pl/
Moodle               2.5(Build:20130514)            /home/antun/public_html/moodle2/moodle/
Moodle               2.5+(Build:20130530)           /home/antun/public_html/moodle/moodle/
MyBB                 1.6.10                         /home/antun/public_html/mybb/Upload/
SMF                  2.0.4                          /home/antun/public_html/smf/
Wordpress            3.5.1                          /home/antun/public_html/wp/wordpress
e107                 1.0.4                          /home/antun/public_html/e107/
phpBB                3.0.11                         /home/antun/public_html/phpbb/phpBB3/
Scrips detected: 16

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

