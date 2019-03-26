#!/bin/bash

# Using this script you can install google-chrome all latest distributions stable, beta & dev/unstable

# Add google-chrome repo
echo -e "[google-chrome]\nname=google-chrome\nbaseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch/\nenabled=1\ngpgcheck=1\ngpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub" > /etc/yum.repos.d/google-chrome.repo

# Install google chrome latest stable version
yum install -y -q google-chrome-stable
#yum install -y -q google-chrome-beta
#yum install -y -q google-chrome-unstable

# Install google chrome all latest available distributions beta, stable and dev/unstable
#yum install -y -q google-chrome*
