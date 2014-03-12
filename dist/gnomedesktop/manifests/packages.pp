class gnomedesktop::packages ()  {

  # cjkuni-fonts-common - gets chinese character for ohmyzsh terminal (smt)
  package { "dejavu-sans-mono-fonts":
    ensure => installed,
  }

  package { "bitmap-fangsongti-fonts":
    ensure => installed,
  }

  #is there a way package groups can be done with the package type?
  exec { 'groupInstall xWindow':
    unless  => '/usr/bin/yum grouplist "X Window System" | /bin/grep "^Installed Groups"',
    command => '/usr/bin/yum -y groupinstall "X Window System"',
    notify  => [
                Service["network"],
                Exec['recompile guest additions']
              ], 
    timeout => 0
  }

  exec { 'groupInstall Desktop':
    unless  => '/usr/bin/yum grouplist "Desktop" | /bin/grep "^Installed Groups"',
    command => '/usr/bin/yum -y groupinstall "Desktop"', 
    timeout => 0
  }

  exec { 'groupInstall Desktop Platform':
    unless  => '/usr/bin/yum grouplist "Desktop Platform" | /bin/grep "^Installed Groups"',
    command => '/usr/bin/yum -y groupinstall "Desktop Platform"',
  }

  exec { 'groupInstall Fonts':
    unless  => '/usr/bin/yum grouplist "Fonts" | /bin/grep "^Installed Groups"',
    command => '/usr/bin/yum -y groupinstall "Fonts"',
  }

  # exec { 'groupInstall Internet Browser':
  #   unless  => '/usr/bin/yum grouplist "Internet Browser" | /bin/grep "^Installed Groups"',
  #   command => '/usr/bin/yum -y groupinstall "Internet Browser"',
  # }

  exec { 'recompile guest additions':
    command => '/etc/init.d/vboxadd setup'
  }

  

}