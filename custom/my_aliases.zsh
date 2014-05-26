#
# Defines jdoyle specific aliases
#

# Workflow Shortcuts
# -----------------------------------------------------
	alias sassync="git checkout sites/all/themes/wheretraveler2_desktop_new_mobile/css/global.css sites/all/themes/wheretraveler2_desktop_new_mobile/css/global-blessed1.css sites/all/themes/wheretraveler2_desktop_new_mobile/css/contest.css"
	alias rsyncwt="drush rsync @wt.live:%files @wt.local:%files"

# Web Server Environment
# -----------------------------------------------------
	alias webstart="sudo apachectl start"
	alias webstop="sudo apachectl graceful-stop"
	alias webrestart="sudo apachectl restart"
	alias dbstart="launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist"
	alias dbstop="launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist"
	alias ftpstart="sudo launchctl load /System/Library/LaunchDaemons/ftp.plist"
	alias ftpstop="sudo launchctl unload /System/Library/LaunchDaemons/ftp.plist"

# Flush DNS
# -----------------------------------------------------
	alias flushdns="dscacheutil -flushcache"

# MySQL
# -----------------------------------------------------
	alias sqltrace="sudo tail -f /var/log/mysql/error.log"
	alias cdmysql="/usr/local/mysql"
	alias cdmysqldata="/usr/local/var/mysql"
	alias mysqlconf="open /private/etc/my.conf"
	alias newdb="mysqladmin -u root -p create"

	newdb() {
		mysqladmin -u root -p create $1; #$1=database name
		mysql CREATE USER $2'@localhost' IDENTIFIED BY $3; #$2=new user, $3=new user pword
		mysql GRANT ALL PRIVILEGES ON $1 TO $2'@localhost';
		mysql FLUSH PRIVILEGES;
	}

# SSH Shortcuts
# -----------------------------------------------------
	alias sshdev="ssh admin@mccdev01.mcc-anthill.net"


# Servers and Networks
# -----------------------------------------------------
	# Pretty PS
	# Format the output of the ps command. For example compare:
	# $ps axu | grep mysql | prettyps to $ps axu | grep mysql
	alias prettyps="~/bash/prettyps.sh"


#Editors
# -----------------------------------------------------
	alias ccmds="vim ~/Documents/Documentation/cli-commands.txt"
	alias vi="reattach-to-user-namespace mvim"
	alias vim="reattach-to-user-namespace vim"
	alias dashbash="open dash://bash:{query}"

	# Open a file in Sublime #
	sub() { open $1 -a "Sublime Text" }

	# Open a file in Coda #
	coda() { open $1 -a "Coda 2" }

	# Open a file in BBEdit #
	bbe() { open $1 -a "BBEdit" }


# Files and Directories
# -----------------------------------------------------
	alias l='ls -la'            # Show files in one column.
	alias ll='ls -lh'           # Show human readable.
	alias lh='ls -lhA'          # Show hidden files.
	cs() { cd $@ && ls; }				# Auto ls when changing to directories



# Git
# -----------------------------------------------------
	alias gadd="git add -A"
	alias gpom="git pull origin master"
	alias gpush="git push"
	alias gstat="git status"

	gcom() {
		git commit -m $1
	}

	gacom() {
		git add -A && git commit -m $1 && git push
	}
