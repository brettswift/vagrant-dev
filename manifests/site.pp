
# Exec { path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin"}

#in migration - currently using own hand bombed nodejs module.  
node nodejs {

  #TODO: hook in hiera to solve duplicate package warnings
  # mentioned here. 
  class {'ohmyzsh':
    user_name => 'vagrant',
  }
  
  stage { 'first':}
  stage { 'last':}

  Stage['first'] ->
  Stage['main'] ->
  Stage['last']
 
  class{ 'mongodb_old':
    projectName     => "uptime",
    dbName          => "brettUptime",
    dbUser          => "uptimeUser",
    dbPass          => "password",
    stage           => last
  }

  # class {'nvm::install':} ->
  class {'nodesite':

    node_version  => "0.10.10",
    git_url       => "https://github.com/brettswift/uptime.git",
    git_branch    => "statusCheck",
    file_to_run   => "app.js",
    stage         => last
  }
}

node /^clean*/ {
  class {'ohmyzsh':
    user_name => 'vagrant',
  }

  }

node default {
  #vagrant up will build an empty shell if node definition doesn't exist.
}