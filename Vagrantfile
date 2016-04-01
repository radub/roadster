# -*- mode: ruby -*-
# vi: set ft=ruby :

VMNAME = File.basename(File.expand_path('..', Dir.pwd)) + '.local'

Vagrant.configure(2) do |config|

    # config vm profile
    config.vm.box = 'puppetlabs/ubuntu-14.04-64-puppet'
    config.vm.box_url = 'https://vagrantcloud.com/puppetlabs/ubuntu-14.04-64-puppet'
    config.vm.hostname = VMNAME
    config.vm.define VMNAME do |t| end

    # config networking
    config.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true
    config.vm.network "forwarded_port", guest: 443, host: 4443, auto_correct: true
    config.vm.network "private_network", type: "dhcp"

    # config shared folders
    config.vm.synced_folder "./", "/vagrant", :nfs => true
    config.vm.synced_folder "../code", "/opt/web", :nfs => true

    # update /etc/hosts file on host machine
    unless Vagrant.has_plugin?('vagrant-hostmanager')
        puts 'vagrant-hostmanager plugin is not installed!'
    else
        config.hostmanager.enabled = true
        config.hostmanager.manage_host = true
        config.hostmanager.ignore_private_ip = false
        config.hostmanager.include_offline = true
        config.hostmanager.ip_resolver = proc do |vm, resolving_vm|
            if hostname = (vm.ssh_info && vm.ssh_info[:host])
                `vagrant ssh -c "hostname -I"`.split()[1]
            end
        end
    end

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
