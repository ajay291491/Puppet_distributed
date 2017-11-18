class log_manager::params {
	case $::operatingsystem {
		'redhat', 'CentOS' : {
			$dir = '/var/log'
		}
		'SunOS': {
			$dir = '/var/adm'
		}
	}
	$file = "${dir}/tools.log"
	$cache_dir = '/var/tools/cache'
	$cache_file = "${cache_dir}/cache.dat"
}
