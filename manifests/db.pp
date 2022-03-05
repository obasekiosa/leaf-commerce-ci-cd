exec {"apt-update":
    command => "/usr/bin/apt-get update"
}

package {"mysql-server":
    ensure => installed,
    require => Exec["apt-update"],
}

file { "/etc/mysql/mysql.conf.d/mysqld.cnf":
    owner => mysql,
    group => mysql,
    mode  => 0644,
    content => template("/vagrant/manifests/mysqld.cnf"),
    require => Package["mysql-server"],
    notify  => Service["mysql"],
}

service { "mysql":
    ensure  => running,
    enable  => true,
    hasstatus  => true,
    hasrestart  => true,
    require  => Package["mysql-server"],
}

exec { "store-schema":
    unless => "mysql -uroot store_schema",
    command => "mysqladmin -uroot create store_schema",
    path    => "/usr/bin/",
    require => Service["mysql"],
}

exec { "remove-anonymous-user": 
    command => "mysql -uroot -e \"DELETE FROM mysql.user
                                WHERE user='';
                                FLUSH PRIVILEGES\"",
    onlyif  => "mysql -u' '",
    path    => "/usr/bin",
    require => Service["mysql"],
}

exec { "store-user":
    unless => "mysql -ustore -pstoresecret store_schema",
    command => "mysql -uroot -e \"GRANT ALL PRIVILEGES ON
                                  store_schema.* TO 'store'@'%'
                                  IDENTIFIED BY 'storesecret';\"",
    path  => "/usr/bin",
    require  => Exec["store-schema"],
}