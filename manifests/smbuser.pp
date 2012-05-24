define samba::smbuser (
  $usernames,
  $ensure='present',
  $file='/etc/samba/smbusers'
) {

  include samba::smbuser::augeas

  case $ensure {

    present: {
      samba::smbuser::username {$usernames:
        ensure => $ensure,
        file  => $file,
        user   => $name,
      }
    }

    absent: {
      $changes = "rm ${name}"
    }

    default: { fail ("Wrong value for ensure: ${ensure}") }
  }

  augeas {"Manage ${name} in ${file}":
    context   => "/files${file}",
    load_path => "/usr/share/augeas/lenses/contrib/",
    changes   => $changes,
    notify => Service['samba'],
    require => Package['samba'],
  }
}
