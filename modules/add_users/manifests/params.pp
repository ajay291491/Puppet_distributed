class add_users::params {

	case $::operatingsystem {
		'Linux', 'CentOS', 'Redhat' 	: {$lab_user_home = '/home/labuser'}
		'SunOS', 'Solaris', 'Aix' 	: {$lab_user_home = '/export/home/labuser'}
		default				: {fail("unable to determine the operating system fact")}
				
	}

	$lab_user_prfile 	= "${lab_user_home}/.profile"
	$uptime_days 		= $::facts['system_uptime']['days']
	$uptime_time 		= $::facts['system_uptime']['hours']
	$uptime_sec  		= $::facts['system_uptime']['seconds']

	if $::operatingsystem =~ /CentOS|Linux|Redhat|Fedora/ {
		$uptime = ["Days : ${uptime_days}", "Hours : ${uptime_time}", "Seconds : ${uptime_sec}"]
	} else {
		$uptime = $::uptime
	}
}

