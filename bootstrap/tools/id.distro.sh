#!/usr/bin/env bash
# ID the distro you're running on and set to environment variables:
# 1. TDISTRO = {fedora,ubuntu,centos,redhat}
# 2. TRELEASE = x[.y]
#
# The matching is not very good and matches only for one specific version.
# So far this will be enough.

# RedHat based systems
if [ -e /etc/redhat-release ]; then
  INFOSTRING=$(cat /etc/redhat-release)
fi
if [ -e /etc/debian_version ]; then
  INFOSTRING=$(cat /etc/debian_version)
fi

case "${INFOSTRING}" in
  'Fedora release 24 (Twenty Four)')
    TDISTRO='fedora'
    TRELEASE=24
    ;;
  CentOS*)
    TDISTRO='centos'
    if [[ "${INFOSTRING}" =~ 6 ]]; then
      TRELEASE=6
    else
      TRELEASE=7
    fi
    ;;
  jessie/sid)
    TDISTRO='ubuntu'
    TRELEASE=14.04 
    ;;
  'Red Hat Enterprise Linux Server release 7.2 (Maipo)')
    TDISTRO='redhat'
    TRELEASE=7.2
    ;;
  *)
    echo "No known system found for ${INFOSTRING}."
    exit 1
    ;;
esac
