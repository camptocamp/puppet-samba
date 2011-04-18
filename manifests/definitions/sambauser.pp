



define samba::user($samba_user,$samba_pw){

  file { "/etc/samba/.${samba_user}.pw":
      owner => root,
      group => root,
      mode => 600,
      content => template("samba/user.pw.erb"),
    }


  exec { "setpw":
    unless => "/usr/bin/pdbedit -u $samba_user ",
    command => "/usr/bin/pdbedit -a -t $samba_user < /etc/samba/.${samba_user}.pw",
    require => [File["/etc/samba/.${samba_user}.pw"],Package["samba-common"]]
  }


}
