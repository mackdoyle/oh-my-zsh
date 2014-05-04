# Command to switch easily switch LAMP stacks when using multiple installations on OS X
# Currently supported environments: default osx, brew, bitnami mamp, acquia dev studio

#Define script vars
new_apache = ''
new_php = ''
new_mysql = ''
toggle = 0

# Define all locations
# ------------------------------------------

# default
osx_apache = ''
osx_mysql = '/System/Library/LaunchDaemons/org.apache.httpd.plist'
osx_php = ''

# macports
mps_apache = '/opt/local/etc/LaunchDaemons/org.macports.apache2/apache2.wrapper'
mps_mysql = '/opt/local/etc/LaunchDaemons/org.macports.mysql/mysql.wrapper'
mps_php = '/usr/local/opt/php54/bin'

# homebrew
brw_apache = ''
brw_mysql = '~/Library/LaunchAgents/homebrew.mxcl.mysql.plist'
brw_php = ''

# acquia
acq_apache = ''
acq_mysql = ''
acq_php = ''



# Stop currently running web services services
launchctl unload

# Switch to new service

# Start web services
launchctl load $switch_apache; $switch_mysql $switch_php
launchctl load


# Define services for various stacks
function macports_stack(toggle){
	if [[toggle = 0]]; then
		sudo /opt/local/etc/LaunchDaemons/org.macports.apache2/apache2.wrapper stop
		sudo /opt/local/etc/LaunchDaemons/org.macports.mysql/mysql.wrapper stop
	else
		sudo /opt/local/etc/LaunchDaemons/org.macports.apache2/apache2.wrapper start
		sudo /opt/local/etc/LaunchDaemons/org.macports.mysql/mysql.wrapper start
	fi
}


#switch default

#switch macports

#switch brew

#switch bitmamp

