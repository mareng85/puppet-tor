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

# Default class Tor
class tor(
  $ensure = $tor::params::ensure,
) inherits tor::params {

  class {'::tor::repos':}

  package {'tor':
    ensure  => present,
    require => Yumrepo['Tor-repo'],
  }

  service {'tor':
    ensure  => $ensure,
    require => Package['tor'],
  }
}
