# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

    # provider virtualbox
	config.vm.provider :virtualbox do |virtualbox, override|
		virtualbox.gui = false
		virtualbox.customize ["modifyvm", :id, "--name", "vm-name", "--memory", "1024"]
	end

	# default vm configuration if no provider is specified
	config.vm.box = "puppetlabs/ubuntu-14.04-64-puppet"
	config.vm.network "forwarded_port", guest: 80, host: 8080
	config.vm.synced_folder "./", "/vagrant", :nfs => true, :nfs => { :mount_options => ["dmode=777","fmode=777"] }
	config.vm.synced_folder "../app", "/opt/web", :nfs => true, :nfs => { :mount_options => ["dmode=777","fmode=777"] }
	config.vm.network :private_network, ip: "192.168.58.100"

	config.vm.provision "puppet" do |puppet|
		puppet.options = ['--verbose --debug']
		puppet.environment_path = "environments"
    		puppet.environment = "local"
	end

end
