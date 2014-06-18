# Author: Andrea Tosatto <andrea.tosy@gmail.com>

### Require plugins
require 'vagrant-hostsupdater'

Vagrant.configure("2") do |config|

    config.vm.box = 'puppetlabs/centos-6.5-x86_64-puppet'
    config.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-puppet.box'

    ### VM Specs customization
    config.vm.provider :virtualbox do |vb|
        vb.name = "Vagrant Node"
        vb.customize ["modifyvm", :id, "--memory", "2048"]
    end

    ### NFS shared folder | Require nfs-utils  
    config.vm.synced_folder "workspace", "/home/vagrant/workspace", :nfs => true

    ### Puppet configuration
    config.vm.define :vagrant_node do |project|

        project.vm.hostname = "node.vagrant.dev"
        project.vm.network :private_network, ip: "33.33.33.30"

        # VM hostname aliases | Require vagrant-hostsupdater (https://github.com/cogitatio/vagrant-hostsupdater)
        project.hostsupdater.aliases = ["api.palermobybus.dev"]

        ### Pass installation procedure over to Puppet (see `manifests/vagrant_node.pp`)
        project.vm.provision :puppet do |puppet|
            puppet.manifests_path = "manifests"
            puppet.module_path = "modules"
            puppet.manifest_file = "vagrant_node.pp"
            puppet.options = [
                '--verbose',
            ]
        end

    end
end
