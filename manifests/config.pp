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
  $pluginsync     = $puppet::pluginsync
  $puppetenv      = $puppet::environment
  $puppetstart    = $puppet::start ? {
    'yes'   => 'yes',
    default => 'no',
  }
  $puppetserver   = $puppet::server

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

  $cron_ensure = $puppet::start ? {
    'cron'  => 'present',
    default => 'absent',
  }

  cron { 'puppet':
    ensure  => $cron_ensure,
    command => '/usr/bin/puppet agent --onetime --no-daemonize --verbose',
    user    => 'root',
    minute  => '10',
    require => [Class['puppet::install']],
  }

  file { '/etc/cron.d/puppet.cron':
    ensure  => absent,
    content => template('puppet/puppet.cron.erb'),
    owner   => 'root',
    group   => 'root',
    require => [Class['puppet::install']],
  }

}
