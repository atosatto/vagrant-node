Exec {
    path => ['/usr/local/bin/:/bin/:/usr/bin/'],
}

### Mongodb
class { 'mongodb':
    use_10gen => true,
}

## NodeJS
class { 'nodejs':
    version => 'stable',
}

### NFS
package { 'nfs-utils':
    ensure  => installed,
}

### Others Packages
package { ['nano', 'vim-enhanced', 'yum-utils', 'mlocate', 'git', 'curl', 'subversion']:
    ensure => latest,
}

### Welcome messages
host { 'self':
    ensure          => present,
    name            => $fqdn,
    host_aliases    => [$hostname],
    ip              => $ipaddress,
}

file { 'motd':
    ensure  => file,
    path    => '/etc/motd',
    mode    => '0644',
    content => "\n***** Vagrant Development VM ****\n\n\nOS:\t\t${operatingsystem} ${operatingsystemrelease}\nHOSTNAME:\t${fqdn}\nPUBLIC IP:\t${ipaddress_eth1}\n\n\n",
}
