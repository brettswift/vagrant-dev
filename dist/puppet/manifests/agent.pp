class puppet::agent (
  $master_ip   = undef,
  $http_proxy_host = undef,
  $domain = undef
) {

  include puppet

  # Types

  host { 'puppet':
    ensure       => present,
    ip           => $master_ip,
  }

  Host['puppet'] ->
  Class['puppet']

  ssh_authorized_key { 'puppetmaster.${domain}.ad':
    ensure => present,
    key    => 'AAAAB3NzaC1yc2EAAAABIwAAAQEAx7+noH990LpyAqVyHwuJGzHKhoapBrTTuOFEaIryJXoe8+CwbP0en5Lmkw1HBM0HW7Bwwkbu3uQPkjsdbONiEjdYBRZuRWywOj5ni7VmHeRe8bkHnPsZ496MDXsOmPiCJGTKWIQpo/AxUS5fxCV+4vCPmk4myaZPxWEw/l90202FpegeCP5OPoqUOxGQs7boEgXHRm2YA1UKYGuvT6FQRYtJn9EHa3EP6bBhLaJSZnUTRN5X6dToZxu27cXg8H1kEpENTC1avYcRj3RFnrrAY8Fb1RMxVriu+IUJAF4eP2JAaK4I5EPeYYtVnaEQqkGsDM25UeVDO0h7lcfg6gOJ3Q==',
    type   => 'ssh-rsa',
    user   => 'root',
  }

# TODO: this should go into the Vagrantfile
  # # Add hiera.yaml to Vagrant hosts to be able to run Puppet in standalone mode.
  # if $::application != 'ppt' and $::app_stack_id == '999' {
  #   file { '/etc/puppetlabs/puppet/hiera.yaml':
  #     source => 'puppet:///modules/puppet/hiera.yaml',
  #     mode   => '0644',
  #   }

  #   Class['puppet'] ->
  #   File['/etc/puppetlabs/puppet/hiera.yaml']
  # }

}
