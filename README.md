# Roadster

[![Build Status](https://travis-ci.org/radub/roadster.svg?branch=master)][travis]

[travis]: http://travis-ci.org/radub/roadster

# Purpose
Boilerplate project for creating VMs with custom user configurations. 

# Prerequisites
- VirtualBox (5.0.0 or later)
- Vagrant (1.7.4 or later)

### Vagrant plugins
- vagrant-hostmanager (1.6.1 or later)

### VirtualBox plugins
- Guest Additions (4.3.22 or later)

### Inside the VM
- Puppet (4.2.1 or later)
- Ruby (2.1.6 or later)

# Setup
```
$ vagrant plugin install vagrant-hostmanager // this is required only once
$ mkdir project // the directory name will be used later on so chose it carefully
$ cd project
$ mkdir code // this directory will hold the app's code
$ git clone git@github.com:radub/roadster.git
```
right now if you run ````ls -la```` in the project directory you should get:
```
total 0
drwxr-xr-x   5 user  staff   170 Oct 28 16:13 .
drwxr-xr-x   6 user  staff   204 Oct 28 14:53 ..
drwxr-xr-x  31 user  staff  1054 Nov  9 12:32 code
drwxr-xr-x  10 user  staff   340 Oct 28 14:58 roadster
```

You are now ready to spin-up the VM! Step into the car and start the engine!
```
$ cd roadster
$ vagrant up
```
go grab a coffee ... :) then come back. You will be prompted for the administrator password. The script also takes care of updating the ````/etc/hosts```` file.

Open your browser and access: ```` http:\\project.local````.

That's it!


# Vagrant commands

Typing `vagrant` from the command line will display a list of all available commands.

Be sure that you are in the same directory as the Vagrantfile when running these commands!

## Common Vagrant Commands
- `vagrant up`          -- starts vagrant environment (also provisions only on the FIRST vagrant up)
- `vagrant status`      -- outputs status of the vagrant machine
- `vagrant halt`        -- stops the vagrant machine
- `vagrant reload`      -- restarts vagrant machine, loads new Vagrantfile configuration
- `vagrant provision`   -- forces reprovisioning of the vagrant machine
- `vagrant ssh`         -- connects to machine via SSH
- `vagrant destroy`     -- stops and deletes all traces of the vagrant machine

## Tips
- `vagrant -v`                  -- Get the vagrant version
- `vagrant global-status`       -- outputs status of all vagrant machines
- `vagrant suspend`             -- Suspends a virtual machine (remembers state)
- `vagrant resume`              -- Resume a suspended machine (vagrant up works just fine for this as well)
- `vagrant reload --provision`  -- Restart the virtual machine and force provisioning
- `vagrant provision --debug`   -- Use the debug flag to increase the verbosity of the output
- `vagrant push`                -- Yes, vagrant can be configured to [deploy code](http://docs.vagrantup.com/v2/push/index.html)!
- `vagrant up --provision | tee provision.log`  -- Runs `vagrant up`, forces provisioning and logs all output to a file
