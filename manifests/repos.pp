# Setup repos
class tor::repos {

  case $::operatingsystem {
    'RedHat','CentOS': {
      yumrepo {  'Tor-repo':
          baseurl  => "https://deb.torproject.org/torproject.org/rpm/el/${::operatingsystemmajrelease}/${::architecture}",
          descr    => 'Tor project repository',
          enabled  => 1,
          gpgcheck => 0
      }
    }
    'Fedora': {
      yumrepo {  'Tor-repo':
        baseurl  => "https://deb.torproject.org/torproject.org/rpm/fc/${::operatingsystemmajrelease}/${::architecture}",
        descr    => 'Tor project repository',
        enabled  => 1,
        gpgcheck => 0
      }
    }
    default: { notify {'Repos does not exists for your OS!':}}
  }
}
