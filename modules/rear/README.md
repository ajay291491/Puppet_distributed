# rear

[![Build Status](https://travis-ci.org/thbe/puppet-rear.png?branch=master)](https://travis-ci.org/thbe/puppet-rear)
[![Puppet Forge](https://img.shields.io/puppetforge/v/thbe/rear.svg)](https://forge.puppetlabs.com/thbe/rear)
[![Coverage Status](https://coveralls.io/repos/thbe/puppet-rear/badge.svg?branch=master&service=github)](https://coveralls.io/github/thbe/puppet-rear?branch=master)

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with rear](#setup)
    * [What rear affects](#what-rear-affects)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

The rear module install and configures the Relax and Recovery suite (http://relax-and-recover.org)
that provides an easy to use script to create backup and recovery images.

## Setup

### What rear affects

* Install rear package
* Setup basic rear cron job

## Usage

### ReaR minimal

```puppet
class { 'rear':
  output_url => 'nfs://192.168.100.1/backup/rear',
  backup_url => 'nfs://192.168.100.1/backup/rear'
}
```

### ReaR with backup schedule and SSH password

```puppet
class { 'rear':
  output_url => 'nfs://192.168.100.1/backup/rear',
  backup_url => 'nfs://192.168.100.1/backup/rear'
  backup_schedule => 'weekly'
  ssh_root_password => 'HyperSecret01x!'
}
```

## Reference

Here is the list of parameters used by this module.

### `$output`

Backup method that is used
Default value is ISO

### `$output_url`

Backup target that is used for backup method
Default value is 'nfs://192.168.0.1/srv/rear'

### `$backup`

Backup method that is used
Default value is NETFS

### `$backup_url`

Backup target that is used for backup method
Default value is 'nfs://192.168.0.1/srv/rear'

### `$backup_schedule`

Backup frequency (daily, weekly or monthly)
Default value is none

### `$ssh_root_password`

Password that could be used to log into the recover live image as root
Default value is 'Recover!N0W'

## Limitations

This module has been built on and tested against Puppet 4.0 and higher.

The module has been tested on:

* RedHat Enterprise Linux 6/7
* Scientific Linux 6/7
* CentOS Linux 6/7

Testing on other platforms has been light and cannot be guaranteed.

## Development

If you like to add or improve this module, feel free to fork the module and send
me a merge request with the modification.
