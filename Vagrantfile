# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

    # default vm configuration
    config.vm.box = config.user.vm.box if !config.user.vm.box.to_s.empty?
    config.vm.box_url = config.user.vm.box_url if !config.user.vm.box_url.to_s.empty?
    config.vm.hostname = config.user.vm.host.hostname if !config.user.vm.host.hostname.to_s.empty?
    config.hostsupdater.aliases = config.user.vm.host.alias if !config.user.vm.host.alias.empty?

    config.vm.network "forwarded_port", guest: 80, host: 8080
    config.vm.network "forwarded_port", guest: 443, host: 4443
    config.vm.network :private_network, ip: config.user.vm.network.ip if !config.user.vm.network.ip.to_s.empty?

    config.vm.synced_folder "./", "/vagrant", :nfs => true, :nfs => { :mount_options => ["dmode=777","fmode=777"] }
    config.vm.synced_folder config.user.app.code.directory, "/opt/web", :nfs => true, :nfs => { :mount_options => ["dmode=777","fmode=777"] } if !config.user.app.code.directory.to_s.empty?

    # provider virtualbox
    config.vm.provider :virtualbox do |virtualbox|
        virtualbox.gui = config.user.vm.show_gui if !config.user.vm.show_gui.to_s.empty?
        virtualbox.customize ["modifyvm", :id, "--name", config.user.vm.name] if !config.user.vm.name.to_s.empty?
        virtualbox.customize ["modifyvm", :id, "--memory", config.user.vm.memory] if !config.user.vm.memory.to_s.empty?
    end

    # provisioner setup
    config.vm.provision "puppet" do |puppet|
        # puppet.options = ['--verbose --debug']
        puppet.environment_path = "environments"
            puppet.environment = "local"
    end

end
