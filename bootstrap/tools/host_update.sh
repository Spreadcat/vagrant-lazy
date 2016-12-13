#!/usr/bin/env bash
echo 'Running host updates...'

case ${TDISTRO} in
  centos|redhat)
    echo 'Running yum update on host'
    yum clean all
    yum makecache
    yum update -y
    ;;
  ubuntu)
    echo 'Running apt update on host'
    apt-get update
    apt-get upgrade -y
    apt-get autoremove -y
    ;;
  *)
    echo 'unknown distro. cannot update. Abort'
    exit 1
esac
