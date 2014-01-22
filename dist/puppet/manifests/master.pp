class puppet::master {

  include puppet

  # Defaults

  File {
    owner => 'root',
    group => 'root',
  }

  # Types

  file { '/etc/puppetlabs/puppet/hiera.yaml':
    source => 'puppet:///modules/puppet/hiera.yaml',
    mode   => '0644',
  }

  file { '/etc/hiera.yaml':
    ensure  => 'link',
    target  => '/etc/puppetlabs/puppet/hiera.yaml',
  }

  file { '/etc/puppetlabs/puppet-dashboard/enc':
    ensure => 'directory',
  }

  file { '/etc/puppetlabs/puppet-dashboard/external_node_ext':
    source => 'puppet:///modules/puppet/external_node_ext',
    mode => '0755',
  }

  file { '/opt/puppet/share/puppet-dashboard/db/migrate/20130711151027_change_message_column_type_to_medium_text_on_report_logs.rb':
    source => 'puppet:///modules/puppet/20130711151027_change_message_column_type_to_medium_text_on_report_logs.rb',
    mode   => '0644',
    owner  => 'puppet-dashboard',
    group  => 'puppet-dashboard',
  }

  file { '/etc/puppetlabs/puppet/puppet.conf':
    ensure  => present,
    content => template("puppet/puppet.conf.master.erb"),
    owner   => 'pe-puppet',
    group   => 'pe-puppet',
  }

  service { [
    'pe-puppet',
  ]:
    ensure  => running,
    enable  => true,
  }

  exec { 'ssh-keygen root':
    command => 'ssh-keygen -t rsa -N \'\' -f /root/.ssh/id_rsa',
    creates => '/root/.ssh/id_rsa',
    user    => 'root'
  }

  # Dependencies

  File['/etc/puppetlabs/puppet/hiera.yaml'] ->
  File['/etc/hiera.yaml'] ->
  Service['pe-puppet']

  File['/etc/puppetlabs/puppet/hiera.yaml'] ~>
  Service['pe-puppet']

  File['/etc/puppetlabs/puppet-dashboard/enc'] ->
  File['/etc/puppetlabs/puppet-dashboard/external_node_ext'] ->
  Service['pe-puppet']

  Class['puppet'] ->
  Class['puppet::master']
}