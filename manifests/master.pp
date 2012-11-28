# == Class: puppet::master
#
# Manage configuration and service for puppetmaster
#
# === Parameters
#
# [*autosign_nodes*]
#   Set of entries to put in autosign.conf file
#   Default: false
#
# === Examples
#
#  include puppet::master
#
#  class { 'puppet::master':
#    autosign_nodes => ['*.example.com']
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
class puppet::master(
  $autosign_nodes = false
) {

  include puppet
  include puppet::params
  $puppetserver = $puppet::params::puppetserver

  package { 'puppetmaster':
    ensure => installed,
  }

  service { 'puppetmaster':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => [File['/etc/puppet/puppet.conf']],
  }

  if ($autosign_nodes) {
    class { 'puppet::master::autosign':
      nodes => $autosign_nodes,
    }
  }

}
