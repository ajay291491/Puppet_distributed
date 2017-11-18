class add_users {

	include add_users::params
	
	File {
		mode 	=> '644',
		owner	=> 'labuser',
		group	=> 'labuser',
	}
		
	$labuser_home 		= $add_users::params::lab_user_home
	$labuser_profile 	= $add_users::params::lab_user_prfile
	$uptime				= $add_users::params::uptime

	file {"user_home":
		path	=> "$labuser_home",
		ensure	=> 'directory',
		mode	=> '644',
		require	=> User['labuser'],
		}

	user { 'labuser':
  		ensure	=> present,
  		password => "labuser",
		home	=> "$labuser_home",
	}

	file {'lab_user_profile':
		path	=> "$labuser_profile",
		source	=> 'puppet:///modules/add_users/profile',
		require => [File['user_home'], User['labuser']],
	}

	file {'lab_user_identity':
		path	=> "${labuser_home}/identity.dat",
		content	=> template('add_users/function_detect.erb',
				     'add_users/host_details.erb',
					 'add_users/uptime_details.erb'),
	}

	
}
