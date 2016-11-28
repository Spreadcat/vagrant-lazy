#!/bin/bash

YUMPACKAGES='httpd'
APTPACKAGES='apache2'

case ${TDISTRO} in
  centos)
    yum install -y ${YUMPACKAGES}
    ;;
  ubuntu)
    apt-get install -y ${APTPACKAGES}
    ;;
  *)
    echo 'unknown distro. Abort.'
    exit 1
    ;;
esac
