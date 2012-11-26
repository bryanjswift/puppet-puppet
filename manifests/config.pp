class puppet::config {

  $puppetserver = $puppet::server
  $puppetenv    = $puppet::environment
  $puppetstart  = $puppet::start

  file { "/etc/puppet/puppet.conf":
    ensure  => present,
    content => template("puppet/puppet.conf.erb"),
    owner   => "puppet",
    group   => "puppet",
    require => [Class["puppet::install"]],
    notify  => [Class["puppet::service"]],
  }

  file { "/etc/default/puppet":
    ensure  => present,
    content => template("puppet/etc.default.puppet.erb"),
    owner   => "root",
    group   => "root",
    mode    => 0644,
    require => [Class["puppet::install"]],
    notify  => [Class["puppet::service"]],
  }

}
