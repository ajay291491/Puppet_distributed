class nginx {

	file { 'nginx.repo':
		name	=> '/etc/yum.repos.d/nginx.repo',
		ensure	=> 'file',
		owner	=> 'root',
		group	=> 'root',
		mode	=> '0644',
		source	=> 'puppet:///modules/nginx/nginx.repo',
	}

	package { 'nginx':
		name	=> 'nginx',
		ensure	=> 'present',
		require	=> File['/etc/yum.repos.d/nginx.repo'],
	}

	file { 'base_dir':
		name	=> '/var/www/',
		ensure	=> 'directory',
		owner	=> 'root',
		group	=> 'root',
		mode 	=> '0755',
		require	=> Package['nginx'],
	}
	
	file { 'index.html':
		name	=> '/var/www/index.html',
		owner	=> 'root',
		group 	=> 'root',
		mode	=> '0644',
		source 	=> 'puppet:///modules/nginx/index.html',
		#require	=> File['/var/www/'],
	}

	file { 'nginx.conf':
		name	=> "/etc/nginx/nginx.conf",
		owner	=> "root",
		group	=> "root",
		mode	=> '0644',
		source	=> 'puppet:///modules/nginx/nginx.conf',
		require	=> Package['nginx'],
	}

	file { 'default.conf':
		name	=> '/etc/nginx/conf.d/default.conf',
		owner	=> 'root',
		group	=> 'root',
		mode	=> '0644',
		source	=> 'puppet:///modules/nginx/default.conf',
		require	=> Package['nginx'],
		notify	=> Service['nginx'],
	}

	file { 'nginx.service':
		name	=> '/lib/systemd/system/nginx.service',
		owner	=> 'root',
		group	=> 'root',
		mode	=> '0644',
		source 	=> 'puppet:///modules/nginx/nginx.service',
		require	=> Package['nginx'],	
		notify	=> Service['nginx'],
	}

	service { 'nginx':
		ensure	=> 'running',
		enable	=> true,
		require	=> File['nginx.service'],
		subscribe	=> File['nginx.conf'],
	}
	
	$search_entry = "search google.com yahoo.com msn.com"

}
