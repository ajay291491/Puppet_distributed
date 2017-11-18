# Class: rear::params
#
# This module manages rear parameter
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include rear::params
#
class rear::params {
  # Operating system specific definitions
  case $::osfamily {
    'RedHat' : {
      $linux                       = true

      # Package definition
      $package_common              = 'rear'

      # Config definition
      $config_local                = '/etc/rear/local.conf'
      $config_local_template       = 'rear/etc/local.conf.erb'

      # Service definition
      $service_cron_file           = '/etc/cron.d/rear'
      $service_cron_file_template  = 'rear/etc/rear.erb'
    }
    default  : {
      $linux                       = false
    }
  }

  # rear definitions
  $output             = 'ISO'
  $output_url         = 'nfs://192.168.0.1/srv/rear'
  $backup             = 'NETFS'
  $backup_url         = 'nfs://192.168.0.1/srv/rear'
  $backup_schedule    = 'none'
  $ssh_root_password  = 'Recover!N0W'
}
