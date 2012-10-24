define samba::smbuser (
  $usernames,
  $ensure='present',
  $file='/etc/samba/smbusers'
) {

  include samba::smbuser::augeas

  case $ensure {

    present: {
      # Loop on every username in the list
      # TODO: This might be better with a ruby provider
      samba::smbuser::username {$usernames:
        ensure => $ensure,
        file   => $file,
        user   => $name,
      }
    }

    absent: {
      augeas {"Manage ${name} in ${file}":
        incl      => $file,
        lens      => 'SmbUsers.lns',
        changes   => "rm ${name}",
        notify    => Service['samba'],
        require   => Package['samba'],
      }
    }

    default: { fail ("Wrong value for ensure: ${ensure}") }
  }
}
