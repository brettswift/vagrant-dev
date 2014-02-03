
# Exec { path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin"}

#in migration - currently using own hand bombed nodejs module.  
node node-server {

  stage { 'first':}
  stage { 'last':}

  Stage['first'] ->
  Stage['main'] ->
  Stage['last']

  class{ 'puppetforge':
    stage   => first
  }

  class{ 'mongodb':
    projectName     => "uptime",
    dbName          => "brettUptime",
    dbUser          => "uptimeUser",
    dbPass          => "password",
    stage           => last
  }

  # class {'nvm::install':} ->
  class {'nodesite':

    nodeVersion => "0.10.10",
    gitUri      => "https://github.com/brettswift/uptime.git",
    gitBranch   => "statusCheck",
    fileToRun   => "app.js",
    stage       => last
  }
}

node /^clean*/ {
  class {'ohmyzsh':
    user_name => 'vagrant',
  }

}

node /^training*/ {
  class {'ohmyzsh':
    user_name => 'developer',
  }

  include gnomedesktop

}

node default {
  #vagrant up will build an empty shell if node definition doesn't exist.
}