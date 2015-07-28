# tor

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with tor](#setup)
    * [What tor affects](#what-tor-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with tor](#beginning-with-tor)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview
This module sets up Tor anonymous proxy as a client, relay or exit node.

## Module Description
This module sets up Tor anonymous proxy as a client, relay or exit node. 
Then you can do the web almost anonymously. 

## Setup

### What tor affects

* Will create the config file /etc/tor/torrc used by Tor
* If using Tor´sown DNS service, make sure you forward the traffic going to port 53 to port 5353 (or whatever port you set for Tor DNS)

### Beginning with tor

Set your browser proxy settings to listen on 127.0.0.1:9050 using SOCKS5.

## Usage

For using as client:

    class{'::tor::client':}

Same as above, but setting some custom values:

    class{'::tor::client':
      socks_port           => ['127.0.0.1:9000',],
      socks_policy         => [ 'accept *:80', ],
      deamon               => true,
    }

For using as client with Tor DNS and with Control Port:

    class{'::tor::client':
       $ensure          => running,
       $dns_port        => '5353',
       $control_port    => '9051',
    }


For using as relay:

    class{'::tor::relay':}

For using as exit node:
    
    class{'::tor::exitnode':}

## Limitations

This module is tested, as far, only on CentOS 7 running Puppet 4 but should be compatible wihh earlier version of Puppet as well.

## Development

Please check the github repos for this module at https://github.com/maxhope/puppet-tor

