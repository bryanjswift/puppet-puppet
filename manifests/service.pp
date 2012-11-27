# == Class: puppet::service
#
# Manage puppet service
#
# === Parameters
#
# [*start*]
#   Whether or not to start the service
#   Default: $puppet::start
#
# === Examples
#
#  include puppet::service
#
#  class { 'puppet::service':
#    start => 'yes|no',
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
class puppet::service(
  $start = $puppet::start,
) {

  $ensured = $start ? {
    'yes'   => 'running',
    default => 'stopped',
  }

  service { 'puppet':
    ensure     => $ensured,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => [Class['puppet::install']],
  }

}
