class puppet(
  $environment = "production",
  $server      = "puppet",
  $start       = "yes",
) {

  if ($environment == "") {
    fail("environment must be defined")
  }

  if ($server == "") {
    fail("server must be defined")
  }

  validate_re($start, '^(yes|no)$', 'The $start value must be yes or no.')

  include puppet::install
  include puppet::config
  include puppet::service

}
