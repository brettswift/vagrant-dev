class nodesite (
    $git_url 				= undef,
    $git_branch 		= $nodesite::params::git_branch,
    $node_version 	= $nodesite::params::node_version,
    $file_to_run 		= $nodesite::params::file_to_run,
  ) inherits nodesite::params {
 
  include nodesite::packages




		 # class{ 'nvm': 
		 # }

	# require nvm::install
	# class{'nvm::install':}

	# include nodesite::project

	# TODO: use require before class instead of dependencies below? 
	class {'nodesite::project':
			git_url 			=> $git_url,
			git_branch 		=> $git_branch,
			file_to_run 	=> $file_to_run,
			node_version	=> $node_version,
	}
	
  # # Class['nvm'] -> 
  # Class['nodesite::packages'] ->
  # Class['nodesite::project']


	info("##### ---------------->>> git URI:    			$git_url")
	info("node exe: $nvm_nodejs::NODE_EXEC")
}