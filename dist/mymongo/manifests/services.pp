class mongodbOld::services{
  
  require mongodbOld::packages

  service { "mongod":
      enable => true,
      ensure => running,
  }
}