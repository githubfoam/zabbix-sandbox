#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

echo "============================deploy zabbix============================================================="

vagrant plugin install vagrant-libvirt #The vagrant-libvirt plugin is required when using KVM on Linux
vagrant plugin install vagrant-mutate #Convert vagrant boxes to work with different providers

# https://app.vagrantup.com/debian/boxes/buster64
vagrant box add "debian/buster64" --provider=libvirt
vagrant init --template Vagrantfile.provision.bash.erb
vagrant up --provider=libvirt "vg-zabbix-01"

vagrant box list #veridy installed boxes
virsh list --all #show all running KVM/libvirt VMs



echo "============================deploy zabbix finished============================================================="
