class nginx::params {
	$nginx_repo_file = '/etc/yum.repos.d/nginx.repo'
	$httpd_root_dir	= '/var/www/'
	$nginx_conf_dir	= '/etc/nginx'
	$index_file = "$httpd_root_dir/index.html"
	$nginx_conf_file = "$nginx_conf_dir/nginx.conf"
	$nginx_default_file = "$nginx_conf_dir/conf.d/default.conf"
	$nginx_sstmctl_file = '/lib/systemd/system/nginx.service'
}
