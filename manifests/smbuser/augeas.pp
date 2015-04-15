class samba::smbuser::augeas {
  augeas::lens { 'smbusers':
    lens_content => file('samba/lenses/smbusers.aug'),
    test_content => file('samba/lenses/test_smbusers.aug'),
  }
}
