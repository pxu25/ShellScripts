#!/bin/bash
#
#This script creates a new user on the local system
#You will be promoted to enter the ussername(login), the person name, and a password.
#The username, password and host for the account will be display

# Make sure the script is being executed with superuser privileges.
if [[ "${UID}" -ne 0 ]]
then
   echo  'Please run with sudo or as root.'
   exit 1
fi

# Get the username (login).
read -p 'Input your username: ' USER_NAME

# Get the real name (contents for the description field).
read -p 'Your real name: ' REAL_NAME

# Get the password.
read -p 'Your password: ' PASSWORD

# Create the user with the password.
useradd -c "${REAL_NAME}" -m ${USER_NAME}

# Check to see if the useradd command succeeded.
if [[ "${?}" -ne 0 ]]
then
  echo 'The account could not be created.'
  echo 1
fi

# Set the password.
echo ${PASSWORD} |  passwd --stdin ${USER_NAME}

# Check to see if the passwd command succeeded.
if [[ "${?}" -ne 0 ]]
then 
  echo "the password for the acount could not be set."
  exit 1
fi

# Force password change on first login.
passwd -e ${USER_NAME}

# Display the username, password, and the host where the user was created.
echo 
echo "username: ${USER_NAME}"
echo "password: ${PASSWORD} " 
echo "host: ${HOSTNAME}"
exit 0
