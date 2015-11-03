class samba::server inherits samba::common {
  package { 'samba':
    ensure => installed,
  }

  $samba_service_name = $::lsbdistcodename ? {
    'jessie'  => 'smbd',
    default   => 'samba',
  }

  service { 'samba':
    ensure  => running,
    name    => $samba_service_name,
    pattern => 'smbd',
    restart => '/etc/init.d/samba reload',
    require => Package[samba],
  }

  file { '/etc/samba':
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => '0755',
    require => Package[samba],
  }
}
