# Class: rear
# ===========================
#
# This module install Relax and Recover (REAR) on the local node.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `output`
#   Backup method that is used
#   Default value is ISO
#
# * `output_url`
#   Backup target that is used for backup method
#   Default value is 'nfs://192.168.0.1/srv/rear'
#
# * `backup`
#   Backup method that is used
#   Default value is NETFS
#
# * `backup_url`
#   Backup target that is used for backup method
#   Default value is 'nfs://192.168.0.1/srv/rear'
#
# * `backup_schedule`
#   Backup frequency (daily, weekly or monthly)
#   Default value is none
#
# * `ssh_root_password`
#   Password that could be used to log into the recover live image as root
#   Default value is 'Recover!N0W'
#
# Variables
# ----------
#
# No additonal variables are required for this module
#
# Examples
# --------
#
# @example
#    class { 'rear':
#      output_url => 'nfs://192.168.100.1/backup/rear',
#      backup_url => 'nfs://192.168.100.1/backup/rear',
#      backup_schedule => 'weekly'
#    }
#
# Authors
# -------
#
# Thomas Bendler <project@bendler-net.de>
#
# Copyright
# ---------
#
# Copyright 2016 Thomas Bendler, unless otherwise noted.
#
class rear (
  $output            = $rear::params::output,
  $output_url        = $rear::params::output_url,
  $backup            = $rear::params::backup,
  $backup_url        = $rear::params::backup_url,
  $backup_schedule   = $rear::params::backup_schedule,
  $ssh_root_password = $rear::params::ssh_root_password
) inherits rear::params {

  # Validate parameters
  validate_string($rear::output)
  validate_string($rear::output_url)
  validate_string($rear::backup)
  validate_string($rear::backup_url)
  validate_string($rear::backup_schedule)
  validate_string($rear::ssh_root_password)

  if $backup_schedule != none {
    if $backup_schedule != daily {
      if $backup_schedule != weekly {
        if $backup_schedule != monthly {
          warning('Not supported backup schedule, switch back to none!')
        }
      }
    }
  }

  # Start workflow
  if $rear::params::linux {
    class{'rear::install': } ->
    class{'rear::config': } ~>
    class{'rear::service': } ->
    Class['rear']
  }
  else {
    warning('The current operating system is not supported!')
  }
}
