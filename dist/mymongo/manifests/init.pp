class mymongo(
	$projectName	= {},
	$dbName 	 		= {},
	$dbUser				= {},
	$dbPass 			= {},
	){

		include mymongo::services

		class{ 'mymongo::config':
			projectName	=> $projectName,
			dbName 	 		=> $dbName,
			dbUser			=> $dbUser,
			dbPass 			=> $dbPass,
		}


		file { "/etc/yum.repos.d/10gen.repo":
		ensure 	=> present,
			source	=> "puppet:///dist/mymongo/10gen.repo",
		}


		File['/etc/yum.repos.d/10gen.repo'] ->
		Class['mymongo::packages'] ->
		Class['mymongo::services'] ->
		Class['mymongo::config']

	}