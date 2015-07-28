class tor::params {
  $ensure		= running
  $socks_port 		= '9050'
  $deamon 		= false
  $data_dir 		= '/var/lib/tor'
  $use_dns_port 	= false
  $use_control_port     = false 
  $or_port		= '9001'
  $nickname		= 'nickname'
  $exit_policy		= 'reject'
 
  if $use_dns_port {
    $dns_port 		= '0'
  }

  if $use_control_port {
    $control_port 	= '9051'
  }

  case $::osfamily {     
    'ArchLinux': {
      $conf = '/etc/tor/torrc'
    }
    'redhat': {
      $conf = '/etc/tor/torrc'
    }
  }
}
