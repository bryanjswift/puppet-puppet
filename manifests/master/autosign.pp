# == Class: puppet::master::autosign
#
# Manage configuration for puppet autosigning
#
# === Parameters
#
# [*nodes*]
#   Set of entries to put in autosign.conf file
#   Default: false
#
# === Examples
#
#  class { 'puppet::master::autosign':
#    nodes => '*.example.com'
#  }
#
#  class { 'puppet::master::autosign':
#    nodes => ['*.example.com']
#  }
#
# === Authors
#
# Bryan J Swift <bryan.j.swift@gmail.com>
#
# === Copyright
#
# Copyright 2012 Bryan J Swift
#
class puppet::master::autosign(
  $nodes = false
) {

  if ($nodes) {
    file { '/etc/puppet/autosign.conf':
      ensure  => present,
      content => template('puppet/autosign.conf.erb'),
      owner   => 'puppet',
      group   => 'puppet',
      require => [Class['puppet::install'], Class['puppet::master']],
      notify  => [Class['puppet::service']],
    }
  }

}
