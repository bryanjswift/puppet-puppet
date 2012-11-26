class puppet::master {

  include puppet
  include puppet::params
  $puppetserver = $puppet::params::puppetserver

  package { "puppetmaster":
    ensure => installed,
  }

  service { "puppetmaster":
    enable     => true,
    ensure     => running,
    hasrestart => true,
    hasstatus  => true,
    require    => [File["/etc/puppet/puppet.conf"]],
  }

}
