#
# This module will manage host entries in clients 
#
class hosts {

	host {'puppetmaster':
		ensure 		=> 	"present",
		ip		=>	"192.168.1.20",
		name		=> 	"puppetmaster.sathsang.lab.net",
		host_aliases 	=>	"puppetmaster",

	}

	host {'puppetagentsolaris':
        	ensure          =>      "present",
        	ip              =>      "192.168.1.21",
        	name            =>      "puppetagentsolaris.sathsang.lab.net",
        	host_aliases    =>      "puppetagentsolaris",
	}

	host {'puppetagentfedora':
        	ensure          =>      "present",
        	ip              =>      "192.168.1.22",
        	name            =>      "puppetagentfedora.sathsang.lab.net",
        	host_aliases    =>      "puppetagentfedora",
	}

	host {'puppetagentcentos':
		ensure		=> 	"present",
		ip		=>	"192.168.1.23",
		name		=>	"puppetagentcentos.sathsang.lab.net",
		host_aliases	=>	"puppetagentcentos",
	}
}
