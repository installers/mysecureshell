#!/bin/sh

## Uninstaller Script v0.2 for MySecureShell made by Pierre
## MySecureShell Team <teka2nerdman@users.sourceforge.net>

## Language local initialising

LANG=

## Functions Looking for available languages

MyGetLocale()
{
	if [ "$LANG" == "" ] ; then
		echo $1
	else
		tmp=`grep -F "$1=" locales_$LANG | cut -d= -f2-`
		if [ "$tmp" == "" ] ; then
			echo $1
		else
			echo $tmp
		fi
	fi
}

MyListLocale()
{
	echo "The available languages are:"
	grep -F 'DESCRIPTION=' locales_* | cut -d= -f2-
	echo "Usage: ./uninstall.sh xx(language)"
}

if [ "$1" == "" ] ; then
	MyListLocale
	exit 1
else
	if [ -f "locales_$1" ] ; then
		LANG=$1
	fi
fi

clear
MyGetLocale 'uninst?'
read ans
if [ $ans = "y" ] ; then
	sudo rm -f /bin/MySecureShell /usr/libexec/sftp-server_MSS /usr/bin/sftp-who /usr/bin/sftp-state	
	sudo cat /etc/shells | sudo grep -v MySecureShell > /tmp/shells~
	sudo mv /tmp/shells~ /etc/shells

# Only for Mac OS X
	if [ -d /Applications/MySecureShell ] ; then
		sudo rm -Rf /Applications/MySecureShell
	else
		break
	fi
	if [ -d /Library/Receipts ] ; then
		sudo rm -Rf /Library/Receipts/MySecureShell*
	else
		break
	fi

# Delete configuration ?
	MyGetLocale 'delconf?'
	read ans2
	if [ $ans2 = "y" ] ; then
		sudo rm -f /etc/ssh/sftp-config
	else
		break
	fi
	MyGetLocale 'mssuninstok!'
else
	MyGetLocale 'mssuninstfail'
fi