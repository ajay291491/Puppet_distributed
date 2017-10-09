class health_check::params {

	$uptime_days = $::facts['system_uptime']['days']
	$max_uptime  = '60'
	$due_for_reboot = ($max_uptime - $uptime_days)
}
