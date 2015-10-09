# -*- mode: ruby -*-
# vi: set ft=ruby :

VMNAME = File.basename(File.expand_path('..', Dir.pwd)) + '.local'

Vagrant.configure(2) do |config|

    # default vm configuration
    config.vm.box = 'puppetlabs/ubuntu-14.04-64-puppet'
    config.vm.box_url = 'https://vagrantcloud.com/puppetlabs/ubuntu-14.04-64-puppet'
    config.vm.hostname = VMNAME

    config.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true
    config.vm.network "forwarded_port", guest: 443, host: 4443, auto_correct: true
    config.vm.network "private_network", type: "dhcp"

    config.vm.synced_folder "./", "/vagrant", :nfs => true, :nfs => { :mount_options => ["dmode=777","fmode=777"] }
    config.vm.synced_folder "../code", "/opt/web", :nfs => true, :nfs => { :mount_options => ["dmode=777","fmode=777"] }

    # provider virtualbox
    config.vm.provider :virtualbox do |virtualbox|
        virtualbox.gui = false
        virtualbox.customize ["modifyvm", :id, "--name", VMNAME]
        virtualbox.customize ["modifyvm", :id, "--memory", 1024]
    end

    # provisioner setup
    config.vm.provision "puppet" do |puppet|
        # puppet.options = ['--verbose --debug']
        puppet.environment_path = "environments"
            puppet.environment = "local"
    end

end
