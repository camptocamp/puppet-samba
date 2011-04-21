

define samba::share($name,$path,
                    $guestok='',
                    $writeable='',
                    $comment='',
                    $validusers='',
                    $writelist='',
                    $forcegroup='',
                    $readonly='',
                    $createmask='')
{

    concat::fragment{$name:
        target => "/etc/samba/smb.conf",
        content => template("samba/smb_share.erb"),
        order => 10,

    }

}


