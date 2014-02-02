class nodesite::project(
		$git_url 	 		= {},
		$git_branch		= 'master',
		$file_to_run 		= 'app.js',
		$node_version 	= {},
	){
	# require nodesite::nvm

	$projectDir = "/tmp/gitProjects"

	# regex to get project name, used in folder
	$projectNameDirty = regsubst($git_url, '^(.*[\\\/])', '')
	$projectName = regsubst($projectNameDirty, '.git', '')

	
	class { 'nvm_nodejs':
  	user    => 'vagrant',
  	version => $node_version,
	}

	file { "/tmp/gitProjects":
		ensure => directory,
	}

	exec { "cloneProject":
		command => "/usr/bin/git clone --depth 1 $git_url  &>>$projectName.log",
		cwd			=> "/tmp/gitProjects",
		creates => "/tmp/gitProjects/$projectName.log",
	}

	exec { "git_branch":
		command => "/usr/bin/git checkout $git_branch",
		cwd			=> "/tmp/gitProjects/$projectName",
		# TODO: notify npm purge exec.
	}

	exec { "pullProject":
		command => "/usr/bin/git pull origin $git_branch",
		cwd			=> "/tmp/gitProjects/$projectName",
	}

	exec { "npmInstall":
		command => "$nvm_nodejs::NPM_EXEC install",
		cwd			=> "/tmp/gitProjects/$projectName",
	}

	# TODO: change to service - create init.d service template
	exec { "runProject":
		command => "$nvm_nodejs::NODE_EXEC $file_to_run &",
		cwd			=> "/tmp/gitProjects/$projectName",
		user 		=> "vagrant",
	}
 
 	Class['nvm_nodejs'] -> 
	File['/tmp/gitProjects'] -> 
	Exec['cloneProject'] -> 
	Exec['git_branch'] -> 
	Exec['pullProject'] -> 
	Exec['npmInstall'] -> 
	Exec['runProject']

	info("##### ---------------->>> git URI:    $git_url")
	info("##### ---------------->>> project name:    $projectName")
	info("node exe: $nvm_nodejs::NODE_EXEC")

}