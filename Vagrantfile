# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "centos/7"
  config.vm.provider :libvirt do |vb|
    vb.memory = 2048
    vb.cpus = "1"
  end

	config.vm.define "zabbix" do |node|
		node.vm.synced_folder ".", "/vagrant", type: "sshfs"
		node.vm.hostname = "zabbix.local"
		node.vm.network :private_network, ip: "10.0.15.30"
		node.vm.provision :hostmanager
		node.vm.provision :ansible do |ansible|
			ansible.playbook = "playbook.yml"
			ansible.compatibility_mode = "2.0"
			ansible.limit = "all"
		end
	end

	config.vm.define "proxy" do |node|
		node.vm.synced_folder ".", "/vagrant", type: "sshfs"
		node.vm.hostname = "proxy.local"
		node.vm.network :private_network, ip: "10.0.15.31"
		node.vm.provision :hostmanager
	end

	config.vm.define "client1" do |node|
		node.vm.synced_folder ".", "/vagrant", type: "sshfs"
		node.vm.hostname = "client1.local"
		node.vm.network :private_network, ip: "10.0.15.32"
		node.vm.provision :hostmanager
	end

	config.vm.define "client2" do |node|
		node.vm.synced_folder ".", "/vagrant", type: "sshfs"
		node.vm.hostname = "client2.local"
		node.vm.network :private_network, ip: "10.0.15.33"
		node.vm.provision :hostmanager
	end

	if Vagrant.has_plugin?("vagrant-hostmanager")
		config.hostmanager.enabled = false
		config.hostmanager.manage_host = true
		config.hostmanager.manage_guest = true
		config.hostmanager.include_offline = true
	end
end
