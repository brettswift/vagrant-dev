class mongodbOld::packages{
  package{"mongo-10gen-server":
    ensure => latest,
  }

  package{"mongo-10gen":
    ensure => latest,
  }
}