#!/bin/bash

#Updates edited script into relavent install folders for developement

cp --force /home/ratbag/dportalroot/bootstrap.txt /etc/dpportal/run/bootstrap.sh

chmod a+x /etc/dpportal/run/bootstrap.sh

cp --force /home/ratbag/dportalroot/setBrand.txt /etc/dpportal/run/setBrand.sh

chmod a+x /etc/dpportal/run/setBrand.sh

cp --force /home/ratbag/dportalroot/dpportal.txt /etc/dpportal/run/dpportal.sh

chmod a+x /etc/dpportal/run/dpportal.sh

cp --force /home/ratbag/dportalroot/install.txt /etc/dpportal/run/install.sh

chmod a+x /etc/dpportal/run/install.sh

cp --force /home/ratbag/dportalroot/uninstall.txt /etc/dpportal/run/uninstall.sh

chmod a+x /etc/dpportal/run/uninstall.sh