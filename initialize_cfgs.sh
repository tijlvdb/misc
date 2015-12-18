#!/bin/bash

# Script to copy relevant configs from root and user to box to set preferred defaults

# Files that should exist
read -d '' filelist <<-"EOF"
root/.bashrc
root/.vimrc
user/.bashrc
user/.vimrc
EOF

# Check if argument was passed; arg = Username
if [ $# -gt 0 ]
  then
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]
      then
        echo "Usage: $0 [userName]"
        exit 1
      else
        destuser=$1
    fi
fi

# --------------------------------------------------------------------------------------------
# Functions used
# --------------------------------------------------------------------------------------------

# copy_file in argument
function copy_file {
  # Some comments
  # set homedir
  homedir=$(eval echo "~$destuser")
  #echo cp "$2" "$homedir/${2#*/}"
  cp -v "$2" "$homedir/${2#*/}"
  #echo chown "$destuser" "$homedir/${2#*/}"
  chown -v "$destuser" "$homedir/${2#*/}"
}

# check if username exists on system
function check_user {
  eval "id -u $1 > /dev/null 2> /dev/null"
  ret=$?
  if [ $ret -eq 0 ] 
    then
      return $true
    else 
      return $false
  fi
}



# Validate if files exist
echo -n "Validating against filelist..."
IFS=$'\n'
err=false
for i in $filelist
  do
    if [ ! -f $i ] 
      then
        # Print file that doesn't exist
        echo -en "\n Missing file: $i"
        err=true
    fi
done
if [ "$err" = true ];
  then
    echo -en "\nDid you sync from github? \n"
    exit 2
fi
echo -en "OK\n"

# Dest user is read from $1 earlier; but if it is empty challenge user, surely he has forgotten it
if [ -z "$destuser" ];
  then 
    echo -en "Username not specified; please specify user: "
    read destuser
fi
if check_user $destuser;
  then 
    echo "Proceeding for $destuser"
  else 
    echo "User not found: $destuser"
    exit 4
fi
# Copy file to location
for i in $(echo "$filelist" | grep user)
  do
    copy_file $destuser $i
done

# Root user is pretty static
destuser="root"
if check_user $destuser;
  then
    echo "Proceeding for $destuser"
  else
    echo "User not found: $destuser"
    exit 4
fi

for i in $(echo "$filelist" | grep root)
  do
    copy_file $destuser $i
done


