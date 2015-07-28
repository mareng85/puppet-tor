# Params class for Tor module
class tor::params {
  $ensure               = running
  $socks_port           = ['127.0.0.1:9050',]
  $socks_policy         = [ 'accept *:*', ]
  $deamon               = false
  $data_dir             = '/var/lib/tor'
  $or_port              = '9001'
  $nickname             = 'nickname'
  $exit_policy          = ['reject *:25', 'reject *:119', 'reject *:135-139', 'reject *:445', 'reject *:563', 'reject *:1214', 'reject *:4661-4666', 'reject *:6346-6429', 'reject *:6699', 'reject *:6881-6999', 'accept *:*']
  $dns_port             = undef
  $control_port         = undef
  $bandwidthrate        = '5 MB'
  $bandwidthburst       = '10 MB'
  $contactinfo          = 'your name name@email'

  case $::osfamily {
    'ArchLinux': {
      $conf = '/etc/tor/torrc'
    }
    'redhat': {
      $conf = '/etc/tor/torrc'
    }
    default: { notify{'Module yet not supported for your OS!':}  }
  }
}
