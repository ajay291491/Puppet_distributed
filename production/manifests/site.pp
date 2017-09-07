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
# Node definition for puppetagentcentos.sathsang.lab.net
#
#node 'puppetagentcentos.sathsang.lab.net' {
#
#	notify { "This policy should only applied to puppetagentcentos": }
#	file { '/etc/issue':
#		ensure => "present",
#		owner  => "sathsang",
#		group  => "sathsang",
#		mode   => "644",
#		content => "Manged by puppetmaster ",
#	}
#}

#
# Node definition for puppetagentcentos.sathsang.lab.net and puppetagentdefora.sathsang.lab.net
#
node /^client.+0[1-9].svr.apac.sathsang.net$/ {
	
	notify { 'node_def_message':
		message => "This is a common policy which cater to both centos and feroda agent on sathsang.lab.net domain",
	}
	package {'samba.x86_64':
		ensure => "installed",
		name   => "samba.x86_64",
	}	
	file {'dns_config':
		name	=> '/etc/resolv.conf',
		owner	=> 'root',
		group	=> 'root',
		mode	=> '0644',
		source	=> 'puppet:///modules/sathsang_dns/resolv.conf',
	}
	include rear
	include hosts
}

#
# Configuration ends
#
