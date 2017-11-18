class sysinfo {
  
  include sysinfo::params
  $sysinfo_dir = $sysinfo::params::sysinfo_dir
  $package_manager = hiera(package_manager)
  $network_manager = hiera(network_manager)
  $ntp_manager     = hiera(ntp_manager)
  $ntp_servers     = hiera(ntp_servers)
  $service_manager  = hiera(service_manager)

  File {
    owner	=> 'root',
    group	=> 'root',
    mode 	=> '0644',
  }

  file {"$sysinfo_dir":
    ensure	=> directory,
    mode	=> '0755',
    before	=> File['system_info_file', 'function_file'],
  }

  file {'system_info_file':
    name 	=> "${sysinfo_dir}/sysinfo.dat",
    ensure 	=> file,
    content	=> template('sysinfo/sysinfo.erb'),
    require	=> File["$sysinfo_dir"]
  }

  file {'function_file':
    name 	=> "${sysinfo_dir}/hostfunction.txt",
    ensure 	=> file,
    source	=> 'puppet:///modules/sysinfo/hostfunction.txt',
  }
}
