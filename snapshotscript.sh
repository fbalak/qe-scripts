#!/bin/bash -x

# qemu+ssh://hostname/ - server where vms are
hypervisor=""

# list of vms
node_list=""

if [ -z "$1" -o "$1" = "-h" -o "$1" = "--help" -o "$1" = "-help" -o "$1" = "--h" ]; then
  echo -e "Usage: $0 _action_\n Where _action_ is virsh action for domain";
  exit
fi

for i in ${node_list}; do virsh --connect ${hypervisor} $1 $i; done 
