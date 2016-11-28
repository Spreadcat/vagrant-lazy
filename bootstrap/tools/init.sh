#!/bin/bash

YUMPACKAGES='vim screen tcpdump tree telnet'
APTPACKAGES='vim screen tcpdump tree telnet'

echo "Installing tools"

case "${TDISTRO}" in
  centos)
    yum install -y ${YUMPACKAGES}
    timedatectl set-timezone Europe/Oslo
    ;;
  ubuntu)
    apt-get install -y ${APTPACKAGES}
    ;;
  *)
    echo 'unknown os. abort.'
    exit 1
esac

