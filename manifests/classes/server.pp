class samba::server inherits samba::common {
  package { "samba":
    ensure => installed,
  }

#  Needs to be samba on da debian box apparently I modified this to smb "
#case $operatingsystem {
#    Debian,Ubuntu: { include apache::debian}
#    RedHat,CentOS: { include apache::redhat}
#    default: { notice "Unsupported operatingsystem ${operatingsystem}" }
#  }

#$lsbdistid ? {
#      default => "/etc/httpd/conf.d/foreman.conf",
#      "Ubuntu" => "/etc/apache2/conf.d/foreman.conf"
#    },

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


 file {"/etc/samba/smb.conf":
    content => template("samba/smb.conf.erb"),
    mode    => 0644, 
    owner   => root, 
    group   => root,
    require => [ Package[samba] ],
    notify  => [ Service[samba] ],
  }
}
