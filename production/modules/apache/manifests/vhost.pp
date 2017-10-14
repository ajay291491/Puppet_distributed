define  apache::vhost (

	#Intiger	$port,
	#String $doc_root,
	$priority 	= '10',
	$vhost_name	= "$title",
	$server_name	= "$title",
	$logdir		= "/varlog/httpd",

) {

	include apache	
	include apache::params
	$document_root = hiera('docroot')
        $port   =  hiera('port')

			
	package {"$apache::params::httpd_pkg" :
		ensure	=> 'present',
	}
			
	file {"$apache::params::httpd_conf_dir":
		ensure	=> 'directory',
	}
	file {"${apache::params::httpd_conf_dir}/${title}.conf" : 
		ensure	=> 'file',
		owner	=> 'root',
		group	=> 'root',
		mode	=> '0644',
		content	=> template('apache/httpd.conf.erb'),
		require	=> Package["$apache::params::httpd_pkg"],
	}
}
