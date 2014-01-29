# TODO: move defaults to nodesite.params, and load defaults
class ohmyzsh (
    $user_name = {},
){

  include ohmyzsh::packages
  include ohmyzsh::services

  user { "dev":
    ensure  => present,
    managehome => true,
    name    => dev,
    groups => ["root"],
    shell   => '/bin/zsh',
    password => '$1$asany8K2$iogsj0FKq5i9x.2P0Cc5I1',
    require => Class['ohmyzsh::packages'],
  }


	 
}