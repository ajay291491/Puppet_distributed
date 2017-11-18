# Class: rear::service
#
# This module manages rear service configuration
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include rear::service
#
class rear::service {

  # Setup crontab configuration files
  file { $rear::params::service_cron_file:
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    path    => $rear::params::service_cron_file,
    content => template($rear::params::service_cron_file_template);
  }
}
