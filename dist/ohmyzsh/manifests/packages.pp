class ohmyzsh::packages{
  package{"make":
    ensure => latest,
  }

  package{"git":
    ensure => latest,
  }


  package {'zsh':
    ensure => latest
  }

  package{"curl":
    ensure => latest,
  }

}