class tor::params {
  $socks_port 		= '9050'
  $deamon 		= false
  $data_dir 		= '/var/lib/tor'
  $use_dns_port 	= false
  
  if $use_dns_port {
    $dns_port 		= '0'
  }

  $use_control_port 	= false
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
