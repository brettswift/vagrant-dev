class ohmyzsh (
    $user_name = $ohmyzsh::params::user_name,
    $theme = $ohmyzsh::params::theme,
    $plugins = $ohmyzsh::params::plugins,
    $aliases = $ohmyzsh::params::aliases,
  ) inherits ohmyzsh::params {

  include ohmyzsh::packages
  include ohmyzsh::services
  include ohmyzsh::zsh

  Class['ohmyzsh::packages'] -> 
  Class['ohmyzsh::services'] -> 
  Class['ohmyzsh::zsh'] 

}