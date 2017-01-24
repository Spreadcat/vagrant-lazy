#!/bin/bash

YUMPACKAGES='vim screen tcpdump tree telnet bash-completion bind-utils'
APTPACKAGES='vim screen tcpdump tree telnet'

echo "Installing tools"

case "${TDISTRO}" in
  centos|redhat)
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

