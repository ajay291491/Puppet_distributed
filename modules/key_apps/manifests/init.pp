class key_apps {

	$hostname = $::hostname
	case $hostname {
		'clientnode01': {
			include rear
			include nginx
		}

		/clientnode0(2|3)/:  {
			include postgresql::client
			include rear
		}
	}
}
			
