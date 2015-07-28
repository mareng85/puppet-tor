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
This module sets up Tor anonymous proxy as a client or relay. Exit node is to be done.

## Module Description
This module sets up Tor anonymous proxy as a client or relay. Exit node is to be done.
Then you can

## Setup

### What tor affects

* Will create the config file /etc/tor/torrc used by Tor
* If using Tor´sown DNS service, make sure you forward the traffic going to port 53 to port 5353 (or whatever port you set for Tor DNS)

### Beginning with tor

Set your browser proxy settings to listen on 127.0.0.1:9050 using SOCKS5.

## Usage

Example: For using as client:
class{'::tor::client':}

Example: For using as client with Tor DNS:
class{'::tor::client':
  $ensure     	=> running,
  $socks_port   => '9050',
  $use_dns  	=> true,
  $dns_port 	=> '5353',
}


Example: For using as relay:
class{'::tor::relay':}

## Limitations

This module is tested, as far, only on CentOS 7 running Puppet 4 but should be compatible wihh earlier version of Puppet as well.

## Development

Please check the github repos for this module at https://github.com/maxhope/puppet-tor

