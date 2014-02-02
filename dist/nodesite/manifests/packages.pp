class nodesite::packages{

  if ! defined(Package['make']) {
    package{"make":
    ensure => latest,
    }
  }

  if ! defined(Package['git']) {
    package{"git":
    ensure => latest,
    }
  }

  if ! defined(Package['curl']) {
    package{"curl":
    ensure => latest,
    }
  }

  if ! defined(Service['iptables']) {
    service { "iptables":
      enable => false,
    ensure => stopped,
    }
  }
}