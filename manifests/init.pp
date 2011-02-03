#
# hosts module
#
# Copyright 2010, Atizo AG
# Simon Josi simon.josi+puppet(at)atizo.com
#
# This program is free software; you can redistribute 
# it and/or modify it under the terms of the GNU 
# General Public License version 3 as published by 
# the Free Software Foundation.
#

class hosts(
  $ipv6 = false,
  $purge_unmanaged = true
) {
  if $purge_unmanaged {
    resources{'host':
      purge => true,
    }
  }
  Host{
    require => File['/etc/hosts'],
  }
  file{'/etc/hosts':
    ensure => present,
  }
  host{
    'localhost.localdomain':
      ip => '127.0.0.1',
      host_aliases => 'localhost';
    $fqdn:
      ip => $ipaddress,
      host_aliases => $hostname;
  }
  host{'localhost6.localdomain6':
    ip => '::1',
    host_aliases => 'localhost6',
    ensure => $ipv6 ? {
      true => ensure,
      default => absent,
    },
  }
}
