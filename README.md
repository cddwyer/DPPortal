# ***STILL UNDER DEVELOPMENT***

## Dark Pal Portal

  _____  _____        _____   ____  _____ _______       _      
 |  __ \|  __ \      |  __ \ / __ \|  __ \__   __|/\   | |     
 | |  | | |__) |_____| |__) | |  | | |__) | | |  /  \  | |     
 | |  | |  ___/______|  ___/| |  | |  _  /  | | / /\ \ | |     
 | |__| | |          | |    | |__| | | \ \  | |/ ____ \| |____ 
 |_____/|_|          |_|     \____/|_|  \_\ |_/_/    \_\______|
                                                               

  written by: Double_D



This is a phishing tool that deploys a wireless (802.11) network via access 
point software 'berate_ap' with a captive portal with customisable branding
and logo, with multiple sign-in options available, all of which will harvest
the credentials entered.

## Description

### Portal and Login Options

This program uses 'berate_ap' and a connected wireless network interface to
bring up a an innocent looking public SSID, once connected the user will be
presented with a captive portal offering various different login options of
various social media networks and services. The currently installed options
are:

Facebook
Google/GMail
Instagram
Microsoft Office 365
Yahoo
Twitter

These are all cloned pages with the login mechanism modified to steal the 
credentials entered all login details will be added to a MySQL database on
your machine.

### Display Panel

There is a 'Display Panel' page. The display panel you can access will show
pull all of the database entries created from our phishing portals and load
them into a HTML table showing you the attempted login, with columns for the
username, password, date/time stamp of the entry and the page/service used in
the attempt.

### Branding Configuration

You can also set the branding, either by creating your own using a wizard I
built into the tool, or by chosing one already built in from a menu.

If you chose to create a new custom one the wizard will ask you for details 
including a local path to a background image and a smaller logo image.
This will then create a new branding set you will be able to chose from the 
menu in the previous step.


## Getting Started

### Dependencies

#### Operating System
* This has been tested on Kali Linux 2023.2 onwards but will probably work 
on Ubuntu as well providing all dependant packags are installed. Run with 
GNU Bash v5.x+, PHP v7.x+

#### Dependent Packages 
*berate_ap 
*eterm
*airmon-ng
*LAMP (Linux, Apache2, MySQL and PHP)
*git (obvs) 
*hostapd-mana
*bash
*util-linux
*procps or procps-ng
*iproute2
*iw
*iwconfig (only if 'iw' doesn't recognise your attached W-NIC)
*dnsmasq
*iptables


### Installing

git clone https://github.com/ddwyer/dpportal.git
cd dpportal
chmod a+x install.sh
./install.sh

### Executing program

* Run dp-portal from terminal
* Choose your desired action from the main menu
```
dp-portal
```

## Help

To display help and usage:
```
dp-portal -h
```
or
```
dp-portal --help
```

## Author

Double_D

## Version History

* 0.2
    * Various bug fixes and optimizations

* 0.1
    * Initial Commit and Push

## License

This project is licensed under the MIT License.

## Acknowledgments

Inspiration, code snippets, etc.
* [awesome-readme](https://github.com/matiassingers/awesome-readme)
* [LitePhish](https://github.com/DarkSecsDevelopers/LitePhish) - Bot detection PHP script and various fake login page clones
* [Pedz](For introducing me to bash/the UNIX command line in general.)