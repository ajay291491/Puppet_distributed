class nginx {

	file { 'nginx.repo':
		name	=> '/etc/yum.repos.d/nginx.repo',
		owner	=> 'root',
		group	=> 'root',
		mode	=> '0644',
		source	=> 'puppet:///modules/nginx/nginx.repo',
	}

	package { 'nginx':
		name	=> 'nginx',
		ensure	=> 'present',
	}
	
	file { 'index.html':
		name	=> '/var/www/index.html',
		owner	=> 'root',
		group 	=> 'root',
		mode	=> '0644',
		source 	=> 'puppet:///modules/nginx/index.html',
	}
}
