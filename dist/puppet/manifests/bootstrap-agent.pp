Exec { path => '/usr/bin:/usr/sbin/:/bin:/sbin' }

class { 'puppet::agent': }

# TODO: use my puppet enterprise bootstrapper. 