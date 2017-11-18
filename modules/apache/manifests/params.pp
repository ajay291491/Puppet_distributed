class apache::params {

	$index_file	= "${documentroot}/index.html"
	$httpd_conf_dir	= '/etc/httpd/conf'
	$systemd_dir	= '/usr/lib/systemd/system'
	$init_dir	= '/etc/rc.d/init.d'
		
	case $::operatingsystem {
		/CentOS|Fedora|Redhat|Linux/ : {
			if $::kernelmajversion =~ /3.10/ {
				$httpd_svc_file	= "${systemd_dir}/httpd.service"
			} elsif $::kernelmajversion =~ /2.6/ {
				$httpd_svc_file	= "{init_dir}/httpd"
			}				
		}
		'Solaris' : { 
			#Disabled for now 
		} 
		'Aix' 	  : { 
			#Disabled for now 
		} 
		default	  : { 
			fail("unable to determine the operating sytem using facter")
		}
	}			
	
	$httpd_pkg = $::kernel ? {
			'Linux'	=> 'httpd.x86_64',
			'Solaris' => 'apache-22',
			'Aix' 	=> 'apache-22',
			default	=> 'httpd.x86_64',
			}
	
}
