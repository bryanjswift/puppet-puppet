# == Class: puppet::config
#
# Manage configuration for puppet service
#
# === Examples
#
#  include puppet::config
#
# === Authors
#
# Bryan J Swift <bryan.j.swift@gmail.com>
#
# === Copyright
#
# Copyright 2012 Bryan J Swift
#
class puppet::config {

  $agent_certname = $puppet::certname
  $puppetserver   = $puppet::server
  $puppetenv      = $puppet::environment
  $puppetstart    = $puppet::start

  file { '/etc/puppet/puppet.conf':
    ensure  => present,
    content => template('puppet/puppet.conf.erb'),
    owner   => 'puppet',
    group   => 'puppet',
    require => [Class['puppet::install']],
    notify  => [Class['puppet::service']],
  }

  file { '/etc/default/puppet':
    ensure  => present,
    content => template('puppet/etc.default.puppet.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => [Class['puppet::install']],
    notify  => [Class['puppet::service']],
  }

}
