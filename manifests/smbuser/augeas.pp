class samba::smbuser::augeas {
  augeas::lens { 'smbusers':
    lens_source => 'puppet:///modules/samba/lenses/smbusers.aug',
    test_source => 'puppet:///modules/samba/lenses/test_smbusers.aug',
  }
}
