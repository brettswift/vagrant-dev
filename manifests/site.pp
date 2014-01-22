
# Exec { path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin"}

node node-server {

	stage { 'first':}
  stage { 'last':}
  
  Stage['first'] -> 
  Stage['main'] -> 
  Stage['last']

  class{ 'puppetforge':
		stage 	=> first
	}

	class{ 'mongodb':
		projectName			=> "uptime",
		dbName 					=> "brettUptime",
		dbUser					=> "uptimeUser",
		dbPass					=> "password",
		stage 					=> last
	}

  # class {'nvm::install':} -> 
	class {'nodesite':

		nodeVersion => "0.10.10",
		gitUri			=> "https://github.com/brettswift/uptime.git",
		gitBranch		=> "statusCheck",
		fileToRun 	=> "app.js",
		stage 			=> last
	}
}

