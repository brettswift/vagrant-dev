class puppet (
  $version = 'puppet-enterprise-3.0.1-el-6-x86_64',
  $role    = 'agent',
) {

  # Types

  # TODO: Don't use this installer, use the bootstrapper
  # installer { "${puppet::version}.tar":
  #   artifact => "com/puppetlabs/pe/3.0.1/${puppet::version}.tar",
  #   extract  => true,
  #   creates  => '/opt/puppet/bin',
  #   command  => "puppet-enterprise-installer -a /tmp/answers.${role}",
  # }

  
 #  file { "/tmp/answers.${role}": 
 #    content => template("puppet/answers.${role}.erb"),
 #    owner   => 'root',
 #    group   => 'root',
	# }

  package { ['puppet', 'hiera', 'facter']: 
    ensure => absent,
  }

  # Dependencies

  File["/tmp/answers.${role}"] ->
  Installer["${puppet::version}.tar"] ->
  Package['puppet'] ->
  Package['hiera'] ->
  Package['facter']
}