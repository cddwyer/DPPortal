#!/bin/bash

############### Setting vars and spitting bars #################

#Set sciptempls for colouring echo lines
warn="\e[1;31m"      # warning (red)
info="\e[1;34m"      # info (blue)
q="\e[1;32m"         # questions (green)

###Some more colour and formatting vars, some may become redundant as I continue to dev and tidy up my project
_bold=$(tput bold)
_underline=$(tput sgr 0 1)
_reset=$(tput sgr0)
_purple=$(tput setaf 171)
_red=$(tput setaf 1)
_green=$(tput setaf 76)
_tan=$(tput setaf 3)
_blue=$(tput setaf 38)


# Print logo
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

Captive portal branding setup.


################################################################
EOF
}

#Function that prints arrow then arguement (just bells and whistles)
function _arrow()
{
    printf "➜ $@"
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

function _safeExit()
{
	echo -n -e "$infoExiting DP_Portal."
	for i in $(seq 1 5)
    do
		sleep 0.5
		echo -n "."
	done
	exit 0
}


function trollMsg()
{

	clear
	_printPoweredBy
	
    #Kicks user out of script for unexpected menu choice displaying an in-joke from my first IT job that no one else will get
	echo -e "$warn\n\n\nI don't know how, but you fucked up a simple menu choice. Try harder next time!\n\n"
	_die "Someone's a JM...!"

}

#Define sigterm/sigint action
trap _safeExit SIGINT SIGTERM


#Gather info on currently installed brands
brandsFile=/etc/dpportal/config/brands.lst
portalWebDir=/var/www/dpportal/
currentBrandS=$(cat /etc/dpportal/config/current.conf)
currentBrandF=$(cat $brandsFile | grep $currentBrandS | awk '{$(NF--)=""; print}')


#Check if running as root first
scriptUser=$(id -u)
if [[ $scriptUser -ne 0 ]]; then
	echo -e "$warn\nThis script needs to be run with sudo privileges. Exiting, no changes have been made...\n"
	exit 1
fi

#Check if service such as Apache is already running

function check_svc_status() {
	local svcname=$1

	if systemctl is-active --quiet "$svcname"; then
		echo "Running"
	else
		echo "Stopped"
	fi
}



################## MENU FUNCTIONS #####################


## Validate and copy image for new branding install ##

function get_image() {
	local prompt_message="$1"
	local new_base_name="$2"
	local short_name="$3"
	local image_path
	local mim_type
	local extension
	local new_filename
	local new_img_path
	
	while true; do
		read -r -p "$prompt_message: " image_path
		
		if [[ ! -f "$image_path" ]]; then
			_error "File does not exist please check the path and try again..."
			continue
		fi
		
		# Check file extension of image
		if [[ ! "${image_path,,}" =~ \.(jpg|jpeg|png)$ ]]; then
			_error "This image doesn't seem to be a jpg or png, try again maybe...?"
			continue
		fi
		
		# check if defo an image
		mime_type=$(file --mime-type -b "$image_path")
		
		
		case "$mime_type" in
			image/jpeg) extension="jpg" ;;
			image/png) extension="png" ;;
			*)
				_error "File is not a valid image type! It must be a PNG or JPG. Sending you back to the main menu for your mistake you must start again!"
				clear
				mainMenu
				
				#If you get weird behaviour at this point then remove 'Continue' from below
				continue
				;;
		esac
		
		new_filename="${new_base_name}.${extension}"
		
		

		
		new_img_path="/var/www/dpportal/brands/$short_name"

		
		
		if cp "$image_path" "$new_img_path/$new_filename"; then
			_success "Images copied to new brand folder location..."
			break
		else
			_error "Yo the images you supplied couldn't copy to the new brand folder, permissions issue maybe?"
		fi
		
	done
	
}



## Set branding ##

function setBrand()
{

	#Shows list of currently installed brandings with corresponding line numbers
	clear
	_printPoweredBy
	local p=1
	_arrow

	echo -e "$_bold\n\nAVAILABLE BRANDING SETS\n "
	echo -e "$_reset "
	echo -e "$_green \n"
	while IFS= read -r line; do
	
		shortBrandName="${line##* }"
		
		fullBrandName="${line% $shortBrandName}"
		
		echo "${p}. (${shortBrandName}) ${fullBrandName}"
		
		echo -e " \n "
		
		((p++))
		
	done < "$brandsFile"
	echo -e "$_reset "
	echo -e "$_tan\n\nThe currently active brand is: $currentBrandF."

	echo -e "$qWhich branding set would you like to enable (enter number from list and press ENTER)...\n\n"
	
    #Reads number input from user
    read brandAnswer
    
    
    if ! [[ "$brandAnswer" =~ ^[1-9][0-9]*$ && "$brandAnswer" -le "$p" ]]; then
		echo -e "$warnInvalid choice! Sending you back to the main menu..."
		echo -e "$_reset "
		sleep 3
		clear
		mainMenu
    fi
    
#   if [[ "$brandAnswer" ! =~ ^[0-9]+$ ]]; then
#		if (( brandAnswer <= p )); then
#			echo " "
#		else
#			echo -e "$warnInvalid choice! Sending you back to the main menu..."
#			echo -e "$_reset "
#			sleep 3
#			clear
#			mainMenu
#		fi
#		echo -e "$warnNot sure that was even a number let alone a valid one! Go back to the main nenu, now!"
#		echo -e "$_reset "
#		sleep 3
#		clear
#		mainMenu
#	fi


	#Gets brand short name from file
    chosenBrandS=$(cat $brandsFile | tail -n+$brandAnswer | head -1 | awk '{print $NF}')
    #Gets brand full name from file
    chosenBrandF=$(cat $brandsFile | tail -n+$brandAnswer | head -1 | awk '{$(NF--)=""; print}')

    #Refresh screen display
    clear
	_printPoweredBy
	_arrow
	echo -e "$infoSetting brand ...\n\n"
	echo "You chose $chosenBrandF"
	sleep 2



	echo "Clearing existing brand...."
	sleep 1
	#Remove in-place branding
	rm -f /var/www/dpportal/index.html
	rm -f /var/www/dpportal/bg-mai*
	rm -f /var/www/dpportal/logo-mai*
	
	echo "Copying new brand files..."
    #Copies across site contents
    cp -f /var/www/dpportal/brands/$chosenBrandS/* /var/www/dpportal/
    cp -f /var/www/dpportal/brands/indextemplate.html /var/www/dpportal/index.html
    sleep 1

    #Sets full name in index file template
    sed -i "s/COMPANYNAME/$chosenBrandF/g" /var/www/dpportal/index.html

    #Puts short name into current brand config file
	echo $chosenBrandS > /etc/dpportal/config/current.conf
	
    #Reloads apache and screen display
	apacheStat=$(check_svc_status "apache2")
	
	if [[ "$apacheStat" == "Running" ]]; then
		systemctl reload apache2
		sleep 1
	elif [[ "$apacheStat" == "Stopped" ]]; then
		systemctl start apache2
		sleep 1
	else
		echo -e "$warnPossible problem with Apache2 service status!"
	fi

    #Notifies user and exits
    echo -e "$infoThe branding has been successfully set to $chosenBrandF.\n\nThank you, you can now run DPPortal with your new branding setup."
    sleep 1.5
	_arrow "Would you like to now launch DPPortal with the new brand set? (y/[n])"
	read runNowChoice
    
	if [[ "$runNowChoice" != "y" ]]; then
		echo -e "$warnYou said no, of gave an invalid choice, exiting now..."
    	_safeExit "Goodbye"
	else
		./bootstrap.sh
	fi

}



## List installed branding sets ##

function listAllBrands()
{

	clear
	_printPoweredBy
	local i=1
	_arrow 
	echo -e "$_purple Lets see what we've got here then..."
	
	echo -e "$_bold\n\nINSTALLED BRANDING SETS\n "
	echo -e "$_reset "
	echo -e "$_green \n"
	while IFS= read -r line; do
	
		shortBrandName="${line##* }"
		
		fullBrandName="${line% $shortBrandName}"
		
		echo "${i}. (${shortBrandName}) ${fullBrandName}"
		
		echo -e " \n "
		
		((i++))
		
	done < "$brandsFile"
	echo -e "$_reset "
	echo -e "$_tan\n\nThe currently active brand is: $currentBrandF."
	echo -e "$_blue Press any key to return to the main menu..."
	read -n 1 -s
	clear
	mainMenu	


}


## Create and install new brand ##

function createNewBrand()
{

	#Standard header
	clear
	_printPoweredBy
	
	echo "$info\n\nLets get this new brand setup.\n\n"


	#Get user friendly name of company branding to use
	echo -e "$qWhat's the user friendly name (in proper case, with spaces but no special characters other than hyphens and underscores etc) of the company branding you're going to use? (e.g. \"Starbucks Pro-Genocide Coffee Company.\")\n\n"
	read newFriendlyName

	if [[ -z "$newFriendlyName" ]]; then
		echo -e "$warn\nThis can't be blank! Bye now. Troll!"
		_error "You done fucked up! Sending you back to the main menu..."
		sleep 3
		mainMenu
	fi
	
	#Check if friendly name already in use
	friendlyUsed=$(cat /etc/dpportal/config/brands.lst | grep -c "$newFriendlyName")
	if [[ $friendlyUsed -ne 0 ]]; then
		_error "Looks like that name already exists in your brands list..."
		_error "Sending you back to the main menu..."
		sleep 3.5
		clear
		mainMenu
	fi

	#Get shortname to use in folder naming
	echo -e "$qWhat's a shortname for the branding? This cannot contain special characters or spaces! (e.g. for Transport For London use \"TFL\" or \"ldntransport\" etc.)\n\n"
	read newShortName
	
	
	if [[ -z "$newShortName" ]]; then
		echo -e "$warnThis can't be blank! Bye now. Troll!"
	    _error "You done fucked up!"
	    sleep 3
	    clear
	    mainMenu
	fi
	
	#Check if short name is alpha numeric with only -'s and _'s
	if [[ ! "$newShortName" =~ ^[A-Za-z0-9_-]+$ ]]; then
		echo -e "$warnYour friendly name has special characters in it or it's blank! \n\nWhat did I tell you about special charaters in short names?! Plank!"
        _error "Daft bastard...!"
		_error "You done fucked up! Sending you back to the main menu..."
	    sleep 2
	    clear
	    mainMenu
	fi
	
	#Check if short name has a space in
    if [[ "$newShortName" =~ [[:space:]] ]]; then
    	echo -e "$warnWhat did I tell you about spaces in the short name?! Daft bastard!"
        _error "You done fucked this right up!"
		sleep 2
		clear
		mainMenu
	fi
	
	#Check if short name already in use
	shortUsed=$(cat /etc/dpportal/config/brands.lst | grep -c "$newShortName")
	if [[ $shortUsed -ne 0 ]]; then
		_error "Looks like that name already exists in your brands list..."
		_error "Sending you back to the main menu..."
		sleep 3.5
		clear
		mainMenu
	fi

	#Make directory for brand
	mkdir -p /var/www/dpportal/brands/$newShortName

	_arrow

	#Get background image
	get_image "Please enter the full file path to a background image for the page in PNG or JPG form only(if it's not big enough, it will end up looking stretched! e.g. /home/me/pic.png)\n\n" "bg-main" "$newShortName"


	#Get logo image
	get_image "Please enter the full file path to a small logo/badge image for the new branding. e.g. /path/to/image.jpg\n\n" "logo-main" "$newShortName"

	
	
	#Write new portal index file
	cp /etc/dpportal/config/indextemplate.html /var/www/dpportal/brands/$newShortName/index.html
	wholeBGName=$(ls /var/www/dpportal/brands/$newShortName/ | grep "bg-main")
	wholeLogoName=$(ls /var/www/dpportal/brands/$newShortName/ | grep "logo-main")
	sed -i 's/REPLACETHISWITHBGIMAGE/$wholeBGName/g' /var/www/dpportal/brands/$newShortName/index.html
	sed -i 's/REPLACETHISWITHLOGOIMAGE/$wholeLogoName/g' /var/www/dpportal/brands/$newShortName/index.html


	#Add brand to list file
	echo "$newFriendlyName $newShortName" >> /etc/dpportal/config/brands.lst
    
    #Inform user branding installed but not set and sends them back to the main menu
    echo -e "$info\nYour new branding has been installed, you must enable it as the active one by returning to the main menu and selecting option 2. \n\nPress any key to return to the main menu..."
    read -s -n 1 "Waiting for key press..."
    mainMenu
    

}


############# Main menu ################
function mainMenu()
{
	clear
	_printPoweredBy
	_arrow
	
	echo -e "$infoWhat would you like to do today?\n\n\n"

	echo -e "\n1. List currently available branding options.\n"
	echo -e "\n2. Enable an installed branding set as the current one to use.\n"
	echo -e "\n3. Install a new branding set.\n"
	echo -e "\n\nq. Quit.\n"
	
	echo -e "$info\n\nThe currently installed brand is: $currentBrandF\n\n\n"
	
	read mainMenuChoice
	
	case $mainMenuChoice in
	    
		1)  listAllBrands;;
	           
		2)  setBrand;;	
           
		3)  createNewBrand;;
	
		q)  _safeExit;;
        
		*)  trollMsg;;
	
	esac
	
}

#Single code line to start process
mainMenu
