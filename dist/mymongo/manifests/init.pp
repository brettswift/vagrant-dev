class mongodbOld(
	$projectName	= {},
	$dbName 	 		= {},
	$dbUser				= {},
	$dbPass 			= {},
	){

		include mongodbOld::services

		class{ 'mongodbOld::config':
			projectName	=> $projectName,
			dbName 	 		=> $dbName,
			dbUser			=> $dbUser,
			dbPass 			=> $dbPass,
		}


		file { "/etc/yum.repos.d/10gen.repo":
		ensure 	=> present,
			source	=> "puppet:///dist/mongodb/10gen.repo",
		}


		File['/etc/yum.repos.d/10gen.repo'] ->
		Class['mongodbOld::packages'] ->
		Class['mongodbOld::services'] ->
		Class['mongodbOld::config']

	}