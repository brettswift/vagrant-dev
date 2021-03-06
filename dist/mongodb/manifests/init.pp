class mongodb(
	$projectName	= {},
	$dbName 	 		= {},
	$dbUser				= {},
	$dbPass 			= {},
	){

		include mongodb::services

		class{ 'mongodb::config':
			projectName	=> $projectName,
			dbName 	 		=> $dbName,
			dbUser			=> $dbUser,
			dbPass 			=> $dbPass,
		}


		file { "/etc/yum.repos.d/10gen.repo":
		ensure 	=> present,
			source	=> "puppet:///modules/mongodb/10gen.repo",
		}


		File['/etc/yum.repos.d/10gen.repo'] ->
		Class['mongodb::packages'] ->
		Class['mongodb::services'] ->
		Class['mongodb::config']

	}