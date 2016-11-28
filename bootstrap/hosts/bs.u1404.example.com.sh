#!/usr/bin/env bash
#
# Example file with custom commands.
# This file gets executed when a host with the hostname
#  'u1404.example.com' is configured in Vagrant and the
#  parameter '-h u1404.example.com' passed to `boot.sh`.
#
# ----------------------------------------------------------------------------
#
# Remove any puppet or chef clients
apt-get purge -y puppet chef chef-zero

# Set the timezone
timedatectl set-timezone Europe/Oslo
