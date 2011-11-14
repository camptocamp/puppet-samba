class samba::server inherits samba::common {
  package { "samba":
    ensure => installed,
  }


  service { "samba":
    ensure  => running,
    pattern => smbd,
    name => $operatingsystem ? { 
	"Debian" =>  "samba",
	"Ubuntu" =>  "samba",
	"CentOS" => "smb" ,
	"RedHat" => "smb" },
    restart => $operatingsystem ? { 
	"Ubuntu" => "/etc/init.d/samba reload",
	"Debian" => "/etc/init.d/samba reload",
	"CentOS" => "/etc/init.d/smb reload" ,
	"RedHat" => "/etc/init.d/smb reload" },
    require => Package[samba],
  }



  file { "/etc/samba":
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => 755,
    require => Package[samba],
  }





# file {"/etc/samba/smb.conf":
#    content => template("samba/smb.conf.erb"),
#    mode    => 0644, 
#    owner   => root, 
#    group   => root,
#    require => [ Package[samba] ],
#    notify  => [ Service[samba] ],
#  }

    include concat::setup 
    concat{"/etc/samba/smb.conf":
	owner => root,
	group => root,
	mode  => 644,
	notify => [ Service[samba]]
    }

 
    concat::fragment{"default_smb_config":
	target => "/etc/samba/smb.conf",
	content => template("samba/smb.conf.erb"),
	order => 01,
    } 

}

   
