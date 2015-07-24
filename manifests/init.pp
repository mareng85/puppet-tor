# == Class: tor
#
# Full description of class tor here.
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
#   class { 'tor': }

class tor(
  $socks_port 	= $tor::params::socks_port,
  $daemon 	= $tor::params::daemon,
  $data_dir 	= $tor::params::data_dir,
  $dns_port 	= $tor::params::dns_port,
) inherits tor::params {
  package {'tor':
    ensure => present,
  }
  
  file {$tor::params::conf:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('tor/torrc.erb'),
    require => Package['tor'],
    notify  => Service['tor'],
  }

  service {'tor':
    ensure => running, 
  }

}
