class ohmyzsh::zsh(
  $theme = $ohmyzsh::theme,
  $user_name = $ohmyzsh::user_name,
  ){

  Exec { path => '/usr/bin:/usr/sbin/:/bin:/sbin' }

  user { "$user_name":
    ensure      => present,
    managehome  => true,
    name        => $user_name,
    groups      => ["root"],
    shell       => '/bin/zsh',
    password    => '$1$asany8K2$iogsj0FKq5i9x.2P0Cc5I1', #==> password
  }

  file {"/etc/sudoers.d/$user_name":
    ensure    => present,
    content   => "$user_name ALL = (ALL)ALL  NOPASSWD: ALL",
    mode      => 0440,
  }

  exec {'ohmyzsh':
    command => 'curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh',
    creates => "/home/$user_name/.zshrc.pre-oh-my-zsh",
    user    => "$user_name",
    cwd     => "/home/$user_name",
  }

  file {'.zshrc':
    path    => "/home/$user_name/.zshrc",
    ensure  => file,
    content => template('ohmyzsh/.zshrc.erb'),
  }

  User["$user_name"] -> 
  Exec['ohmyzsh'] ->
  File['.zshrc']

}