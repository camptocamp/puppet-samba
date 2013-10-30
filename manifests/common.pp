class samba::common {
  package {"samba-common": 
    ensure => installed, 
  }
  exec{"restart samba service":
    command     => "/etc/init.d/samba restart",
    refreshonly => true,
  }

  concat {'/etc/samba/smb.conf':
    owner   => root,
    group   => root,
    mode    => '0644',
    notify  => Exec["restart samba service"],
  }

}
