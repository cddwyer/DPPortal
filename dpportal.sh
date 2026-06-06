#!/bin/bash -x

### Wrapper for DPPortal runtime ###

###Lets gather some vars

##Colours and formatting for stdOut and stdErr
warn="\e[1;31m"      # warning (red)
info="\e[1;34m"      # info (blue)
q="\e[1;32m"         # questions (green)

## Runtime directory
runtimeDir=/etc/dpportal/run

scripDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

theMainArg="$1"

echo "$theMainArg"

###Some more colour and formatting vars, some may become redundant as I continue to dev and tidy up my project
_bold=$(tput bold)
_underline=$(tput sgr 0 1)
_reset=$(tput sgr0)
_purple=$(tput setaf 171)
_red=$(tput setaf 1)
_green=$(tput setaf 76)
_tan=$(tput setaf 3)
_blue=$(tput setaf 38)

#Function that prints arrows and formats stdout stuff then arguement (just bells and whistles)
function _arrow()
{
    printf "➜ $@\n"
}

function _success()
{
    printf "${_green}✔ %s${_reset}\n" "$@"
}

function _error() {
    printf "${_red}✖ %s${_reset}\n" "$@"
}

function _die()
{
    _error "$@"
    exit 1
}


function printUsage()
{
	clear
	_printPoweredBy
    _arrow "Help/Usage:"
	echo -e "$info\nCall DPPortal with the function you wish to run, example: \n\n\ndpportal run (To fire up the portal as configured).\n\ndpportal autorun (To start the portal immediately with the previously configured settings).\n\ndpportal stop (To stop the portal).\n\ndpportal setbrand (To configure the portal's branding).\n\n or \n\ndpportal uninstall (To start the portal uninstaller).\n\n"
	_safeExit
}

function processArgs()
{

	if [[ $# -gt 1 ]]; then
		clear
		_printPoweredBy
		_error "Only one arguement is required."
		_die "I'm off bruv!"
	fi


	argCommand="$theMainArg"

    # Get function called and refer shell to relavent script

	case "$theMainArg" in
	setbrand)
		"$scriptDir/setBrand.sh"
	;;
		run)
			"$runtimeDir/bootstrap.sh"
	;;
	autorun)
		"$runtimeDir/bootstrap.sh ar"
	;;
	stop)
		stopBerate
	;;
	uninstall)
		read -p "Are you sure you want to uninstall this fine tool?! (yes/no)" uninVar
		if [[ "$uninVar" = "yes" ]]; then
			cd $runtimeDir
			./uninstall.sh
		elif [[ "$uninvar" = "no" ]]; then
			clear
			_printPoweredBy
			echo -e "$info\n\nYou said no, DPPortal will now exit. Bye..!"
			sleep 3
			ctrl_c
		else
			clear
			_printPoweredBy
			echo -e "$info\n\nYour answer didn't make any sense. I'm dipping bruv!\n"
			sleep 3
			ctrl_c
		fi
	;;
	help)
		printUsage
	;;
	"")
		"$runtimeDir/bootstrap.sh"
	;;
	*)
		printUsage
	;;
        esac

}

function stopBerate()
{

	clear
	_printPoweredBy
	beratePID=$(pgrep berate_ap | head -1)
	#kill -9 $beratePID
	#a2dissite dpportal.conf
	#a2dissite dppdisplay.conf
	#systemctl stop apache2
	#systemctl stop mysql
	#echo -e "$info\nYou have chosen to quit DPPortal and the associated processes have been stopped."
	
	
	echo "Shutting down services safely..."
 
    # Stop apache2 if running
    if systemctl is-active --quiet apache2; then
        echo "Stopping apache2..."
        systemctl stop apache2
    else
        echo "apache2 is not running."
    fi
 
    # Stop mysql if running
    if systemctl is-active --quiet mysql; then
        echo "Stopping mysql..."
        systemctl stop mysql
    else
        echo "mysql is not running."
    fi
 
    # Disable apache sites if enabled
    if [ -e /etc/apache2/sites-enabled/dpportal.conf ]; then
        echo "Disabling the captive portal site."
        a2dissite dpportal.conf
    else
        echo "dpportal.conf is not enabled."
    fi
 
    if [ -e /etc/apache2/sites-enabled/dppdisplay.conf ]; then
        echo "Disabling the loot display site."
        a2dissite dppdisplay.conf
    else
        echo "dppdisplay.conf is not enabled."
    fi
 
    # Kill berate_ap process if running
    if pgrep -x "berate_ap" > /dev/null; then
        echo "Killing your filthy credential thieving access point"
        pkill -9 "berate_ap"
    else
        echo "berate_ap is not running."
    fi
 
    echo "You're done pal. Slan leat a chara!"

}

function _safeExit()
{
    exit 0
}

function ctrl_c()
{
	echo -e "$info\nExiting DP_Portal."
#    beratePIC=$(pgrep berate_ap | head -1)
#    kill -9 $beratePID
#	systemctl stop apache2 2>&1 /dev/null
#	sleep 1.5
	stopBerate
   _safeExit
}

trap ctrl_c INT TERM

function _printPoweredBy()
{
    cat <<"EOF"



  _____  _____        _____   ____  _____ _______       _      
 |  __ \|  __ \      |  __ \ / __ \|  __ \__   __|/\   | |     
 | |  | | |__) |_____| |__) | |  | | |__) | | |  /  \  | |     
 | |  | |  ___/______|  ___/| |  | |  _  /  | | / /\ \ | |     
 | |__| | |          | |    | |__| | | \ \  | |/ ____ \| |____ 
 |_____/|_|          |_|     \____/|_|  \_\ |_/_/    \_\______|
                                                               

  written by: Double_D




################################################################
EOF
echo -e "$infoThe best DP you'll ever have..."
sleep 1
}

function checkRoot() {

	#Check if running as root first
	scriptUser=$(id -u)
    
	if [[ $scriptUser -ne 0 ]]; then
    	clear
        _printPoweredBy
		echo -e "$warn\nThis script needs to be run with sudo privileges. Exiting, no changes have been made...\n"
		_die "Insufficiently privileged! Bye."
	fi

}


function openingMsg() {

	clear
	_printPoweredBy
	checkRoot
	processArgs

}

#Single line to kick off script
openingMsg
