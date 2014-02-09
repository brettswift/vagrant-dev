class gnomedesktop::terminal (
  $user_name = $gnomedesktop::user_name
  )  {
  
  file { "/home/$user_name/solarized.sh":
    ensure  => present,
    source  => 'puppet:///modules/gnomedesktop/solarized.sh',
    owner   => $user_name,
    mode    => 0644,
  }

  exec { "install solarized":
    command => "/bin/bash /home/$user_name/solarized.sh  2> /home/$user_name/solarized-stderr.log 1>> /home/$user_name/solarized-install.log",
    creates => "/home/$user_name/solarized-install.log",
    user    => $user_name,
  }

  File["/home/$user_name/solarized.sh"] ->
  Exec['install solarized']

}