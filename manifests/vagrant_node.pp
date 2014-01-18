Exec {
  path => ['/usr/local/bin/:/bin/:/usr/bin/'],
}

### Mongodb
class {
  "mongodb": 
    use_10gen => true,
    require => Class['yum::repo::10gen'],
}

## NodeJS
class { 'nodejs': }

### NFS
package {
  'nfs-utils':
    ensure  => installed,
}

### Others Packages
package {
  ['nano', 'vim-enhanced', 'yum-utils', 'mlocate', 'git', 'curl', 'subversion']:
    ensure => installed, 
}

### Welcome messages
host {
  'self':
    ensure => present,
    name => $fqdn, 
    host_aliases => [$hostname], ip => $ipaddress,
}

file {
  'motd':
    ensure => file,
    path => '/etc/motd',
    mode => 0644,
    content => "\n***** Vagrant Development VM ****\n\n\nOS:\t\t${operatingsystem} ${operatingsystemrelease}\nHOSTNAME:\t${fqdn}\nPUBLIC IP:\t${ipaddress_eth1}\n\n\n",
}

### Security Config
case $operatingsystem {

		centos: {

				package {
					['bind-utils']: 
						ensure => installed,
				}

				file { 
					"/etc/selinux/config":
						ensure  => file,
						source  => 'puppet:///modules/config-files/selinux.cfg',
						owner   => root,
						group   => root,
						notify  => Exec["disable_selinux"], 
				}

				exec { 
					"disable_selinux":
						command      => "setenforce 0",
						refreshonly  => true,
						path         => "/usr/sbin";

						"disable_iptables":
							command => "sudo iptables --flush";
				}

		} # end centos configurations

} # end case
