class mymongo::services{
  
  require mymongo::packages

  service { "mongod":
      enable => true,
      ensure => running,
  }
}