Exec { path => '/usr/bin:/usr/sbin/:/bin:/sbin' }

class { 'puppet::master': }
class { 'puppet::r10k': }
