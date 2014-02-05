class gnomedesktop ()  {

  include gnomedesktop::packages
  include gnomedesktop::terminal

  file { "inittab":
    path      => "/etc/inittab",
    content   => template("gnomedesktop/inittab.erb"),
  }


}