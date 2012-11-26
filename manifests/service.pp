class puppet::service {

  service { "puppet":
    enable     => true,
    ensure     => running,
    hasrestart => true,
    hasstatus  => true,
    require    => [Class["puppet::install"]],
  }

}
