class gnomedesktop (
  $user_name = 'vagrant'
  )  {

  include gnomedesktop::packages
  include gnomedesktop::terminal

  file { "inittab":
    path      => "/etc/inittab",
    content   => template("gnomedesktop/inittab.erb"),
  }

  service { "network":
    enable => true,
  	ensure => running,
  	hasrestart => true,
  	require => Class["gnomedesktop::packages"],
  }

  Class['gnomedesktop::packages'] -> 
	Service["network"]


}