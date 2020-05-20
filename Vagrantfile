# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
	config.vm.box = "ubuntu/bionic64"
	config.vm.provider "virtualbox" do |vb|
		# vb.check_guest_additions=false
	end

	# PTP Master
	config.vm.define "vm1" do |vm1|
		vm1.vm.network "public_network", ip: "192.168.55.1"
		vm1.vm.hostname = "vm1"
		vm1.vm.provider "virtualbox" do |vb|
			vb.memory = "1024"
		end
	end

	# PTP Slave
	config.vm.define "vm2" do |vm2|
		vm2.vm.network "public_network", ip: "192.168.55.2"
		vm2.vm.hostname = "vm2"
		vm2.vm.provider "virtualbox" do |vb|
			vb.memory = "1024"
		end
	end

	# PTP Slave
	config.vm.define "vm3" do |vm3|
		vm3.vm.network "public_network", ip: "192.168.55.3"
		vm3.vm.hostname = "vm3"
		vm3.vm.provider "virtualbox" do |vb|
			vb.memory = "1024"
		end
	end

	# Zabbix monitoring, ansible
	config.vm.define "mon" do |mon|
		mon.vm.network "public_network", ip: "192.168.55.4"
		mon.vm.hostname = "mon"
		mon.vm.provider "virtualbox" do |vb|
			vb.memory = "1024"
		end
		mon.vm.network "forwarded_port", guest: 80, host: 80
		mon.vm.provision "shell", path: "provision.sh", keep_color: true
	end
end
