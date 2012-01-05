default[:ssl_terminator][:src_dir] = "/usr/src/stunnel"
default[:ssl_terminator][:stunnel][:version] = '4.32'
default[:ssl_terminator][:stunnel][:url] = "ftp://ftp.stunnel.org/stunnel/archive/4.x/stunnel-#{ssl_terminator[:stunnel][:version]}.tar.gz"
default[:ssl_terminator][:stunnel][:patch] = "http://haproxy.1wt.eu/download/patches/stunnel-#{ssl_terminator[:stunnel][:version]}-xforwarded-for.diff"
default[:ssl_terminator][:stunnel][:prefix] = '/usr'
default[:ssl_terminator][:stunnel][:sysconfdir] = '/etc'