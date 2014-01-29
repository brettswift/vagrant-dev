class ohmyzsh::services{
 
 service { "iptables":
    enable => false,
    ensure => stopped,
  }
}