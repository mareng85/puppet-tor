# Setup Tor as exit node
class tor::exitnode(
  $ensure               = $::tor::params::ensure,
  $or_port              = $::tor::params::or_port,
  $nickname             = $::tor::params::nickname,
  $contactinfo          = $::tor::params::contactinfo,
  $bandwithrate         = $::tor::params::bandwithrate,
  $bandwithburst        = $::tor::params::bandwithburst,
  $exit_policy          = $::tor::params::exit_policy,
) inherits tor::params {
  class{'::tor':
    ensure      => $ensure,
  }

  validate_array($exit_policy)
  $tor_exit_node = true

  file {$::tor::params::conf:
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('tor/torrc.erb'),
      require => Package['tor'],
      notify  => Service['tor'],
    }
}
