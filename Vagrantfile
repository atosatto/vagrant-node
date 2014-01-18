# Author: Andrea Tosatto <andrea.tosy@gmail.com>

Vagrant.require_plugin('vagrant-hostsupdater')
Vagrant.require_plugin('vagrant-vbguest')

Vagrant.configure(2) do |config|

  config.vm.box = "centos-64-x64-puppet"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210.box"

  config.vm.network :forwarded_port, guest: 5858, host: 5858  #remote NodeJS debug

  config.vm.hostname = "node.vagrant.dev"

  ### VM Specs customization
  config.vm.provider :virtualbox do |vb|
    vb.name = "Vagrant NodeHs"
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

  config.hostsupdater.aliases = ["api.palermobybus.dev"]
  # autoupdate vbox guests
  config.vbguest.auto_update = true

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network :private_network, ip: "33.33.33.30"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.module_path = "puppet-modules"
    puppet.manifest_file = "vagrant_node.pp"
    puppet.options = [
        '--verbose',
    ]
  end

end
