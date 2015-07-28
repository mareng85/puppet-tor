# == Class: tor
#
# This module is for setting up Tor anonymous proxy as a client, relay or as an exit node.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the function of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# Sample Usage:
#   class { '::tor': }
#
# For using Tor as client:
#    class { '::tor::client': }
#
# For using Tor as relay:
#    class { '::tor::relay': }  

class tor(
  $ensure = $tor::params::ensure,
)
 inherits tor::params {

  class {'::tor::repos':}

  package {'tor':
    ensure  => present,
    require => Yumrepo['Tor-repo'],
  }

  service {'tor':
    ensure    => $ensure,   
    require   => Package['tor'],
  }
}

class tor::client(
  $ensure 		= $::tor::params::ensure,
  $socks_port           = $::tor::params::socks_port,
  $daemon               = $::tor::params::daemon,
  $data_dir             = $::tor::params::data_dir,
  $use_dns_port         = $::tor::params::use_dns_port,
  $dns_port             = $::tor::params::dns_port,
  $use_control_port     = $::tor::params::use_control_port,
  $control_port         = $::tor::params::control_port,
) inherits tor::params {
  validate_bool($use_dns_port)
  validate_bool($use_control_port)

  notify{'Setting up Tor client...':}
  class{'::tor':
    ensure	=> $ensure,
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

class tor::relay(
  $ensure               = $::tor::params::ensure,
  $or_port		= $::tor::params::or_port,
  $nickname		= $::tor::params::nickname,
  $exit_policy		= $::tor::params::exit_policy,
) inherits tor::params {
    notify{'Setting up Tor relay...':}
    class{'::tor':
      ensure      => $ensure,
    }
    $tor_relay = true

    unless $exit_policy =~ Enum['accept', 'reject'] {
      fail("exit_policy must be either accept or reject! Value passed was: $exit_policy")
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

class tor::exit_node(
  $ensure               = $::tor::params::ensure,
  $or_port              = $::tor::params::or_port,
) inherits tor::params {
  class{'::tor':
    ensure      => $ensure,
  }
}
