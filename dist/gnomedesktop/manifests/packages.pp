class gnomedesktop::packages ()  {

  exec { 'groupInstall xWindow':
    unless  => '/usr/bin/yum grouplist "X Window System" | /bin/grep "^Installed Groups"',
    command => '/usr/bin/yum -y groupinstall "X Window System"',
  }

  exec { 'groupInstall Desktop':
    unless  => '/usr/bin/yum grouplist "Desktop" | /bin/grep "^Installed Groups"',
    command => '/usr/bin/yum -y groupinstall "Desktop"',
  }

  exec { 'groupInstall Desktop Platform':
    unless  => '/usr/bin/yum grouplist "Desktop Platform" | /bin/grep "^Installed Groups"',
    command => '/usr/bin/yum -y groupinstall "Desktop Platform"',
  }

  exec { 'groupInstall Fonts':
    unless  => '/usr/bin/yum grouplist "Fonts" | /bin/grep "^Installed Groups"',
    command => '/usr/bin/yum -y groupinstall "Fonts"',
  }

  exec { 'groupInstall Internet Browser':
    unless  => '/usr/bin/yum grouplist "Internet Browser" | /bin/grep "^Installed Groups"',
    command => '/usr/bin/yum -y groupinstall "Internet Browser"',
  }
}