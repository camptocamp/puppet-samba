define samba::smbuser::username (
  $user,
  $file='/etc/samba/smbusers',
  $ensure='present'
) {

  include samba::smbuser::augeas

  case $ensure {

    present: {
      $changes = "set ${user}/username[.='${name}'] '${name}'"
    }

    absent: {
      $changes = "rm ${user}/username[.=${name}]'"
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
