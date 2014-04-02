vagrant-node
============

Vagrant VirtualMachine providing a Centos 6.5 + NodeJS + MongoDB development stack.

Installation
------------
First of all be sure to have installed on your host machine the latest versions of [Virtualbox](https://www.virtualbox.org/) and [Vagrant](http://www.vagrantup.com/).

Install the `vagrant-hostsupdater` plugin with

	vagrant plugin install vagrant-hostsupdater

Then, clone this project with

	git clone https://github.com/hilbert-/vagrant-node.git

Finally, install the `librarian-puppet` gem to manage the `Puppet` dependencies

	gem install librarian-puppet
	librarian-puppet install
	

Usage
-----

You can startup the VM with 
	
	vagrant up
	
If you see an error similar to this one
	
	[vagrant_node] Mounting NFS shared folders...
	The following SSH command responded with a non-zero exit status.
	Vagrant assumes that this means the command failed!

	mount -o vers=3 33.33.33.1:'/Users/andrea/Documents/Sviluppo/vagrant-vms/vagrant-node/workspace' /home/vagrant/workspace
	
you have to execute
	
	vagrant provision
	vagrant reload
	
since it is caused by the fact that `nfs` has not been yet by the provisioning script.

To share folders or files with the VM you have simply to put them into the `<vagrant-node-path>/workspace`. In fact this directory is mounted via NFS on the `/home/vagrant/workspace` directory of the VM.

Contribute
----------
Contributions are welcome.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request