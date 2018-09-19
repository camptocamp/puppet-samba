define samba::share(
  $path,
  $comment        = false,
  $read_only      = no,
  $create_mask    = '0644',
  $directory_mask = '0755',
  $browsable      = yes,
  $smb_options    = [],
) {

  concat::fragment {$name:
    target  => '/etc/samba/smb.conf',
    content => template('samba/samba-share.erb'),
  }

}
