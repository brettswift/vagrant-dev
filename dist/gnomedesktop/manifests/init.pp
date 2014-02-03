class gnomedesktop ()  {

  include gnomedesktop::packages


  file { "inittab":
    path      => "/etc/inittab",
    content   => template("gnomedesktop/inittab.erb"),
  }


}