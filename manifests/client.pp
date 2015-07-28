# Setup Tor as client
class tor::client(
  $ensure               = $::tor::params::ensure,
  $socks_port           = $::tor::params::socks_port,
  $socks_policy         = $::tor::params::socks_policy,
  $daemon               = $::tor::params::daemon,
  $data_dir             = $::tor::params::data_dir,
  $dns_port             = $::tor::params::dns_port,
  $control_port         = $::tor::params::control_port,
) inherits tor::params {
  validate_array($socks_port)

  notify{'Setting up Tor client...':}
  class{'::tor':
    ensure              => $ensure,
  }
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
