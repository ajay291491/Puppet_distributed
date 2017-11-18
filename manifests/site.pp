# THIS IS THE MAIN MANIFEST FILE FOR SATHSANG LAB INFRASTRUCTURE
# EDIT THIS CONFIGURATION CAREFULLY, ELSE IT CAN CAUSE THE ENTIRE LAB to STOP WORKING
# OWNER : AJAYAGHOSH V L
# SUPPORT : ajay291491@gmail.com
#
#
#
# Below is the default node definition for any node which node part of any node defnition
#
node default {

  notify { "This host is not assigned to any node definition, you must need to review the node definition on master": }
}

#
# Defining required class to include
#


#
# Defining /etc/motd for any nodes in the infra
#

file { '/etc/motd':
       ensure => "present",
       owner => "root",
       group => "root",
       mode => "644",
       content => "
		    * You are entering into Puppet Lab Infrastructure *
                    
		             * Welcome to sathsang.lab.net *

",
}

#
# Node definition for clientnode01 & 02
#

node /^client.+0[1-2].svr.apac.sathsang.net$/ {
	
	notify { 'node_def_message':
		message => "This is a common policy which cater to both centos and feroda agent on sathsang.lab.net domain",
	}
	#notify {'common_alert_message':
	#	message  => 'This node have just going through a puppet run',
	#}
	notify {'This node has just gone through a puppet run':
	}
	package {'samba.x86_64':
		ensure => "installed",
		name   => "samba.x86_64",
	}	
	file {'dns_config':
		path	=> '/etc/resolv.conf',
		owner	=> 'root',
		group	=> 'root',
		mode	=> '0644',
		source	=> 'puppet:///modules/sathsang_dns/resolv.conf',
	}
	file {'app_dir':
		path 	=> '/var/tmp/cache_dir_ppt',
		ensure	=> 'directory',
		mode	=> '0644',
		owner	=> 'sathsang',
		group	=> 'root',
	}
	include rear
	include hosts
}

# 
# Node definition for clientnode03
#

node clientnode03.svr.apac.sathsang.net { 

	notify {'web_notify':
		message	=> "nginx webserver on this host is managed by Puppet",
	}
	include nginx
	include log_manager
	
	$package_name = $::operatingsystem ? {
    	'Centos'    => 'nano.x86_64',
    	'Redhat'    => 'vim-common.x86_64',
		default	    => 'gedit.x86_64',
    	}
	
	Package {'editor_pkg':
		ensure	=> 'present',
		name 	=> "$package_name",
	}
	
	include key_apps
	include health_check
	include add_users
}	

#
# Configuration ends
#
