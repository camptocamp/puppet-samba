class samba::common {
  package {"samba-common": 
    ensure => installed, 
  }
  exec{"restart samba service":
    command     => "/etc/init.d/samba restart",
    refreshonly => true,
  }
}
