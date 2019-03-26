#!/bin/bash

# Using this script you can remove google-chrome all distributions completely

# Remove google chrome all installed version
yum remove -y -q google-chrome*

#yum remove -y -q google-chrome-stable
# To remove version specific
#yum remove -y -q google-chrome-beta
#yum remove -y -q google-chrome-unstable

# Find the current user (created during installation)
export CUSER=$(awk -v val=1000 -F ":" '$3==val{print $1}' /etc/passwd)

# Delete chrome from everywhere
rm -rf /home/$CUSER/.cache/google-chrome*
rm -rf /home/$CUSER/.config/google-chrome*

# Clear the yum caches
yum clean all >> /dev/null
