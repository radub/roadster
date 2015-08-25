# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

# basic VM details
VM_NAME = "vm-name"
VM_PRIVATE_NETWORK_IP = 192.168.58.100

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    # provider virtualbox
    config.vm.provider :virtualbox do |virtualbox, override|
	virtualbox.gui = false
	virtualbox.customize ["modifyvm", :id, "--name", VM_NAME, "--memory", "1024"]
    end

    # provider aws
    config.vm.provider: aws do |aws, override|
    	override.vm.box = 
    end

    # default vm configuration if no provider is specified
    config.vm.box = "puppetlabs/centos-6.6-64-puppet"
    config.vm.network "forwarded_port", guest: 80, host: 8080
    config.vm.synced_folder "../", "/vagrant", :nfs => true, :nfs => { :mount_options => ["dmode=777","fmode=777"] }
    config.vm.network :private_network, ip: VM_PRIVATE_NETWORK_IP

    config.vm.provision "puppet" do |puppet|
    	puppet.options = ['--verbose --debug']
	puppet.environment_path = "environments"
    	puppet.environment = "local"
    end

end
