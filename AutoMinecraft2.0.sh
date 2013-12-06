#!/bin/bash

# Copyright 2013 Matthew Veazey <whodoyouthinkiam@matthewvz.net>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

#Start reading the configuration file
source autominecraft.conf

echo "Welcome $USER!"

#Give the user some options
echo "What would you like to do?"
echo "Option Start: Start the server"
echo "Option Stop: Stop the server"
echo "Option Restart: Restart the server"

#Read the users option
read OPTION

#Start writing the functions
function startServer
{
    if [ -e $SERVERJAR ]
    then
         echo "Starting server!"
    else
         echo "Exiting - Server jar doesn't exist!"
         exit 1
    fi
    
    screen -dmS $SNAME java $JAVAVAR $SERVERJAR
    
    echo "To enter the screen session type in screen -r $SNAME"
    
}

function stopServer
{
    echo "Stopping server!"
    screen -S $SNAME -X stuff 'say Stopping the server!'`echo -ne '\015'`
    screen -S $SNAME -X stuff 'stop'`echo -ne '\015'`
}

function restartServer
{
	echo "Restarting the server!"
	#Manually restarting the server due to stopServer and startServer not wanting to work together properly.
	screen -S $SNAME -X stuff 'say Restarting the server! Shutting down in $RSECONDS'`echo -ne '\015'`
	sleep $RSECONDS
	screen -S $SNAME -X stuff 'stop'`echo -ne '\015'`
	sleep 5
	screen -dmS $SNAME java $JAVAVAR $SERVERJAR
}


if [ $OPTION = Start ]
then
     startServer
fi

if [ $OPTION = Stop ] 
then
     stopServer
fi

if [ $OPTION = Restart ]
then
     restartServer
fi

#For those who are lazy
if [ $OPTION = start ]
then
     startServer
fi

if [ $OPTION = stop ] 
then
     stopServer
fi

if [ $OPTION = restart ]
then
     restartServer
fi
