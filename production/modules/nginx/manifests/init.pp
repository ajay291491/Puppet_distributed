class nginx {

	notify {"Puppet is preparing to configure nginx web server on ${::hostname}":}	
	
	include nginx::params

	File {
		owner	=> 'root',
		group	=> 'root',
		mode	=> '0644',
	}

	file { 'nginx.repo':
		name	=> "$nginx::params::nginx_repo_file",
		ensure	=> 'file',
		source	=> 'puppet:///modules/nginx/nginx.repo',
	}

	package { 'nginx':
		name	=> 'nginx',
		ensure	=> 'present',
		require	=> File['nginx.repo'],
	}

	file { 'base_dir':
		name	=> "$nginx::params::httpd_root_dir",
		ensure	=> 'directory',
		require	=> Package['nginx'],
	}
	
	file { 'index.html':
		name	=> "$nginx::params::index_file",
		source 	=> 'puppet:///modules/nginx/index.html',
		require	=> [ File['base_dir'], Package['nginx'] ]
	}

	file { 'nginx.conf':
		name	=> "$nginx::params::nginx_conf_file",
		source	=> 'puppet:///modules/nginx/nginx.conf',
		require	=> Package['nginx'],
	}

	file { 'default.conf':
		name	=> "$nginx::params::nginx_default_file",
		source	=> 'puppet:///modules/nginx/default.conf',
		require	=> Package['nginx'],
		notify	=> Service['nginx'],
	}

	file { 'nginx.service':
		name	=> "$nginx::params::nginx_sstmctl_file",
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

notify {"Puppet completed  configuring nginx web server on ${::hostname}":}

	
}
