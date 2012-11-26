# == Class: puppet::install
#
# Install the puppet package
#
# === Examples
#
#  include puppet::install
#
# === Authors
#
# Bryan J Swift <bryan.j.swift@gmail.com>
#
# === Copyright
#
# Copyright 2012 Bryan J Swift
#
class puppet::install {

  package { 'puppet':
    ensure => present,
  }

}
