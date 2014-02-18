class gnomedesktop::terminal (
  $user_name = $gnomedesktop::user_name
  )  {
  
  file { "/home/$user_name/solarized.sh":
    ensure  => present,
    source  => 'puppet:///modules/gnomedesktop/solarized.sh',
    owner   => $user_name,
    mode    => 0777,
  }

  exec { "install solarized":
    command => "/bin/bash ./solarized.sh  2> solarized-stderr.log 1>> solarized-install.log",
    creates => "/home/$user_name/solarized-install.log",
    cwd     => "/home/$user_name",
    user    => "$user_name",
  }

  File["/home/$user_name/solarized.sh"] ->
  Exec['install solarized']

}