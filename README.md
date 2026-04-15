# Double_D's Dark Phishing Portal v1.0

```
________ ____________________              __         .__   
\______ \\______   \______   \____________/  |______  |  |  
 |    |  \|     ___/|     ___/  _ \_  __ \   __\__  \ |  |  
 |    '   \    |    |    |  (  <_> )  | \/|  |  / __ \|  |__
/_______  /____|    |____|   \____/|__|   |__| (____  /____/
        \/                                          \/      
```

  written by: Double_D



This is a phishing tool that deploys a wireless (802.11) rogue network access 
point via software 'berate_ap' with a captive portal with customisable branding
and logos, with multiple OAuth style sign-in options available, all of which 
will harvest any credentials entered.

> [!WARNING]
> This project is in version 1.0 - there are bound to be bugs but I think we're now in a place to release v1.0


## Portal and Login Options

This program uses 'berate_ap' and a connected wireless network interface to
bring up a an innocent looking public SSID, once connected the user will be
presented with a captive portal offering various different login options of
various social media networks and services. The currently installed options
are:

* Facebook
* Google/GMail
* Instagram
* Microsoft Office 365
* Yahoo
* X (Formerly Twitter)

These are all cloned pages with the login mechanism modified to steal the 
credentials entered all login details will be added to a MySQL database on
your machine.


## Display Panel

There is a 'Display Panel' page. The display panel you can access will show
pull all of the database entries created from our phishing portals and load
them into a HTML table showing you the attempted login, with columns for the
username, password, date/time stamp of the entry and the page/service used in
the attempt. It is protected by digest authentication. The username is 'pwner'
and the password you will be asked to configure during the installation
process.


## Branding Configuration

You can also set the branding, either by creating your own using a wizard I
built into the tool, or by chosing one already built in from a menu.

If you chose to create a new custom one the wizard will ask you for details 
including a local path to a background image and a smaller logo image.
This will then create a new branding set you will be able to chose from the 
menu in the previous step.


## Prerequisites


### Hardware

* 2GB RAM
* 180MB Disk Space (minimum for DPPortal only, not including OS and dependencies)
* Wirless adapter must be capable of promiscuous mode
* Secondary network interface (optional)

### Operating System

This was developed on Kali Linux 2023.2 but supports/will probably work with:

* Kali 2022.2+
* Ubuntu 18.04+
* Raspberry Pi OS  (tested with Pi OS v9 Stretch on a Pi4)
* Debian based Linux
* Sudo access
* Have a password set for your MySQL root user!

### Package Dependencies

* Bash
* berate_ap 
* eterm
* airmon-ng
* Apache2 
* MySQL/MariaDB
* PHP7+
* hostapd-mana
* util-linux
* procps or procps-ng
* iproute2
* net-tools
* iw
* iwconfig (only if 'iw' doesn't recognise your attached W-NIC)
* dnsmasq
* iptables
* mdk3

* Appropriate 802.11 drivers for your NIC


## Installation

### To install DPPortal on your machine run the following commands.

To clone the repository to your machine:
```
git clone https://github.com/ddwyer/dpportal.git
```
### Step into the parent directory of the repo:
```
cd dpportal
```
### Make the installer executable:
```
chmod a+x install.sh
```
### Kick off the installation process:
```
sudo ./install.sh
```
or
```
sudo bash install.sh
```

1. You will be asked to set a custom domain for your portal but we recommend 
sticking with the default values. 

2. You can set a password for your loot display panel.

3. You will also need to set the password for your MySQL root user during the 
install process.


### Running DPPortal

* Run dpportal from terminal with your main intended function as an arguement. There are three different options.


* To start at the dpportal main menu just run:

```
dpportal
```

* To fire up the portal with the current configuration with no further user input needed (such as to setup a Pi appliance) run:

```
dpportal autorun
```

* To set the portal branding run:

```
dpportal setbrand
```

* To uninstall DPPortal run:

```
dpportal uninstall
```
Though I wouldn't recommend it...


### Show Usage/Help

To display help and usage:

```
dpportal -h
```

or

```
dpportal --help
```


## Legal fluff

> [!CAUTION]
> This tool is meant for educational purposes only, please do not use this on any people, locations or devices that you do not have prior expressed permission to do so with. Using this in any other way is illegal in the USA, UK, EU and most other territories around the world, I am not responsible for any irresponsible or malicious use of this tool.


## Author

Double_D


## Version History

* 1.0 Various big fixes and function re-writes

* 0.3 Editing the README file to test and configure git on my dev box
	* Reformatted some text, clarified instuctions and added credits

* 0.2
    * Various bug fixes and optimizations

* 0.1
    * Initial Commit and Push


## License

This project is licensed under the MIT License. You're free to copy, edit or clone 
any part of my code for your own educational benefit, just please dont plagurise 
the project and claim credit for yourself, that's not cool.


### Acknowledgments

Inspiration, code snippets, etc.
* [awesome-readme](https://github.com/matiassingers/awesome-readme) - Markdown layout cheat sheet (First time I've written a markdown file myself).
* [LitePhish](https://github.com/DarkSecsDevelopers/LitePhish) - Bot detection PHP script.
* [Pedz] - For introducing me to bash/the UNIX command line in my early career and being an all-round legend.
