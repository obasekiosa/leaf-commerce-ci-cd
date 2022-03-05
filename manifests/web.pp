exec { "apt-update":
  command => "/usr/bin/apt-get update"
}

package { ["mysql-client", "tomcat7"]:
  ensure => installed,
  require => Exec["apt-update"],
}

file { "/var/lib/tomcat7/conf/.keystore":
  owner => root,
  group => tomcat7,
  mode => 0640,
  source => "/vagrant/manifests/.keystore",
  require => Package["tomcat7"],
  notify => Service["tomcat7"],
}

file { "/etc/default/tomcat7":
  owner => root,
  group => root,
  mode  => 0644,
  source => "/vagrant/manifests/tomcat7",
  require => Package["tomcat7"],
  notify => Service["tomcat7"],
}

file { "/var/lib/tomcat7/conf/server.xml":
  owner => root,
  group => tomcat7,
  mode => 0644,
  source => "/vagrant/manifests/server.xml",
  require => Package["tomcat7"],
  notify => Service["tomcat7"],
}

service {"tomcat7":
  ensure => running,
  enable => true,
  hasrestart => true,
  hasstatus => true,
  require => Package["tomcat7"],
}

$db_host = "192.168.33.10"
$db_schema = "store_schema"
$db_user = "store"
$db_password = "storesecret"

file { "/var/lib/tomcat7/conf/context.xml":
  owner => tomcat7,
  group => tomcat7,
  mode => 0644,
  content => template("/vagrant/manifests/context.xml"),
  require => Package["tomcat7"],
  notify => Service["tomcat7"],
}

file { "/usr/share/tomcat7/lib/mysql-connector-java-5.1.23.jar":
  owner => tomcat7,
  group => tomcat7,
  mode => 0644,
  source => "/vagrant/manifests/mysql-connector-java-5.1.23.jar",
  require => Package["tomcat7"],
  notify => Service["tomcat7"],
}

file { "/var/lib/tomcat7/webapps/devopsnapratica.war":
  owner => tomcat7,
  group => tomcat7,
  mode => 0644,
  source => "/vagrant/manifests/devopsnapratica.war",
  require => [Package["tomcat7"], File["/usr/share/tomcat7/lib/mysql-connector-java-5.1.23.jar"]],
  notify => Service["tomcat7"],
}
