#!/bin/bash

# Using this script you can remove google-chrome all distributions completely

# Remove google chrome all installed version
yum remove -y -q google-chrome*

#yum remove -y -q google-chrome-stable
## To remove version specific
#yum remove -y -q google-chrome-beta
#yum remove -y -q google-chrome-unstable

# Delete chrome from everywhere
rm -rf $HOME/.cache/google-chrome*
rm -rf $HOME/.config/google-chrome*

# Clear the yum caches
yum clean all >> /dev/null
