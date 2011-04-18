class samba::server inherits samba::common {
  package { "samba":
    ensure => installed,
  }

  service { "samba":
    ensure  => running,
    pattern => smbd,
    restart => "/etc/init.d/smb reload",
    require => Package[samba],
  }

  file { "/etc/samba":
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => 755,
    require => Package[samba],
  }


 file {"/etc/samba/smb.conf":
    content => template("samba/smb.conf.erb"),
    mode    => 0644, 
    owner   => root, 
    group   => root,
    require => [ Package[samba] ],
    notify  => [ Service[samba] ],
  }
}
