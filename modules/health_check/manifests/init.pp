class health_check {

	include health_check::params

	if $health_check::params::uptime_days == 0 {
		notify {"Host : ${::hostname} has rebooted today and will be rebooted in another ${health_check::params::due_for_reboot} days":}
	} elsif $health_check::params::uptime_days > 0 {
		notify {"Host : ${::hostname} rebooted before $uptime_days and will be rebooted in another ${health_check::params::due_for_reboot} days":}
	}
}
