# == Class: puppet
#
# Manage puppet configuration and service.
#
# === Parameters
#
# [*environment*]
#   Set the environment for the puppet agent
#   Default: production
#
# [*pluginsync*]
#   Whether plugins should be synced with the central server.
#   Default: false
#
# [*server*]
#   The server to connect to as the puppetmaster
#   Default: puppet
#
# [*start*]
#   Whether or not the daemon should be started on startup (yes|no).
#   Default: yes
#
# === Examples
#
#  include puppet
#
# === Authors
#
# Bryan J Swift <bryan.j.swift@gmail.com>
#
# === Copyright
#
# Copyright 2012 Bryan J Swift
#
class puppet(
  $certname    = '',
  $environment = 'production',
  $pluginsync  = 'false',
  $server      = 'puppet',
  $start       = 'yes',
) {

  if ($environment == '') {
    fail('environment must be defined')
  }

  if ($server == '') {
    fail('server must be defined')
  }

  validate_re($start, '^(yes|no)$', 'The $start value must be yes or no.')
  validate_re($pluginsync, '^(true|false)$', 'The $pluginsync value must be true or false.')

  include puppet::install
  include puppet::config
  include puppet::service

}
