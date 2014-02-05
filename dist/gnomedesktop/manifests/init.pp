class gnomedesktop (
  $user_name = 'vagrant'
  )  {

  include gnomedesktop::packages
  include gnomedesktop::terminal

  file { "inittab":
    path      => "/etc/inittab",
    content   => template("gnomedesktop/inittab.erb"),
  }


}