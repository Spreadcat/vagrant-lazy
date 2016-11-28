#!/usr/bin/env bash

# -i: Install (string to search for in bootstrap files (<value>.sh)
# -h: hostname (run the <hostname>.sh bootstrap file)
# -u: update (if set to true, update system to the last version)
# -t: install tools (if set to true, install default tools)


# Location of the bootstrap files
BSDIR=/vagrant/bootstrap

# ID the current distro and set env variables
# to match the commands
source $BSDIR/tools/id.distro.sh

# Parse the command line options comming from the vagrant provisioning
# parameter (from the Vagrant file).
update=1
hostname=''
install_tags=''
while getopts i:h:u opt; do
  case $opt in
    i)
      install_tags="${install_tags} ${OPTARG}"
      ;;
    h)
      hostname=`echo $OPTARG | xargs` # Incl. trimming
      ;;
    u)
      update=0
      ;;
  esac
done
shift $((OPTIND -1))


# Apply the updates if requested
if [ ${update} -eq 0 ]; then
  echo 'Applying updates.'
  echo "hi with '$update'"
  if [ -e "${BSDIR}/tools/host_update.sh" ]; then
    source "${BSDIR}/tools/host_update.sh"
  fi
fi

# Include the specific hostname file if available
if [[ $hostname != '' ]]; then
  echo "\$hostname is set. Trying to access file ${BSDIR}/hosts/bs.${hostname}.sh"
  if [ -e "${BSDIR}/hosts/bs.${hostname}.sh" ]; then
    echo "Applying host file ${BSDIR}/hosts/bs.${hostname}.sh"
    source "${BSDIR}/hosts/bs.${hostname}.sh"
  else
    echo "Host file ${BSDIR}/hosts/bs.${hostname}.sh not(!) found."
  fi

  # Update the hostname for some systems
  if [ "$TDISTRO" == 'centos' ]; then
    echo "Setting hostname to $hostname"
    hostnamectl set-hostname ${hostname}
  fi
fi

# Include the install files based on tags.
for i in ${install_tags}; do
  if [ -e "${BSDIR}/${i}/init.sh" ]; then
    echo "Init file for ${i} found."
    source "${BSDIR}/${i}/init.sh"
  else
    echo "Init file for ${i} not(!) found."
  fi
done

echo "Bootstrap done :) !"
