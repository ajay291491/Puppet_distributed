class apache {

	File {
		owner	=> 'root',
		group	=> 'root',
		mode	=> '0644',
	}
	
	include apache::params
	
	$document_root = hiera('docroot')
	$port	=  hiera('port')

	notify {"TEST : $document_root and $port":}
	$websrvr_name=$::hostname	

	apache::vhost {"${websrvr_name}_httpd":
	}

	file {'custom_httpd_path':
		ensure	=> 'directory',
		path	=> hiera('customdir'),
		before	=> File["$document_root"],
	}

	file {"$document_root": 
		ensure	=> 'directory',
		before 	=> File['index.html'],
	}	
		
	file {'index.html':
		path	=> hiera('index'),
		ensure	=> 'file',
		content	=> template('apache/index.html.erb'),
		notify	=> Service['httpd'],
	}
	
	file {'httpd_service':
		path	=> "$apache::params::httpd_svc_file",
		ensure 	=> 'file',
	}
	
	service {'httpd':
		ensure		=> 'running',
		enable		=> 'true',
		subscribe	=> File['httpd_service'],
	}
}
