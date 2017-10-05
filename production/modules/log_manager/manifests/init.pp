class log_manager {	

	File {
		mode    => '0664',
		owner   => 'root',
		group   => 'sathsang',
	}

	include log_manager::params
	$log_dir  = $log_manager::params::dir
	$log_file = $log_manager::params::file

	file {"$log_dir":
		ensure => 'directory',
		before 	=> File["$log_file"],
	}	
	
	file {"$log_file":
		ensure  => 'file',
		content => "All logs are from ${::hostname} and running in ${::timezone}",
	}
}
